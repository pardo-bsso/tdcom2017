source p2_common.m


eb_n0_channel  = [];
eb_n0_source   = [];


# Probability of error using code as detector only
p_error_source = [];
p_error_word   = [];

# Probability of error after applying correction
p_error_source_corrected = [];
p_error_word_corrected   = [];

tic();
for EbN0 = EbN0_steps
    repetitions = 0;
    bit_errors  = 0;
    word_errors = 0;
    bit_errors_corrected  = 0;
    word_errors_corrected = 0;

    while word_errors < WORD_ERROR_COUNT_LIMIT
        repetitions += 1;
        bpsk_noisy_symbols = addnoise(BPSK_SYMBOLS, EbN0);

        noisy_words     = bpsk_demod(bpsk_noisy_symbols);
        corrected_words = correct_95(noisy_words);
        decoded_bits    = decode_95(corrected_words);

        # 1 if that word has a non zero syndrome
        word_errors_idx = sum(mod(noisy_words * H', 2), 2) ~= 0;
        # Counts words whose error pattern turns them into a valid codeword
        word_errors += nnz(sum((noisy_words ~= INPUT_CODEWORDS), 2)) - sum(word_errors_idx);
        detected_word_errors += sum(word_errors_idx);

        word_errors_corrected  += nnz(sum((corrected_words ~= INPUT_CODEWORDS), 2));
        decoded_bits_with_error = (decoded_bits ~= INPUT_ALPHABET);
        bit_errors_per_corrected_word = sum(decoded_bits_with_error, 2);
        bit_errors_corrected  += sum(bit_errors_per_corrected_word);

        # To account for errored bits after ARQ we just ignore everything that was detected
        # The errors left are due to having bit flips that reach another codeword
        bit_errors += sum(bit_errors_per_corrected_word(word_errors_idx~=0));
    end

    p_error_w  = word_errors           / (repetitions * rows(INPUT_CODEWORDS));
    p_error_wc = word_errors_corrected / (repetitions * rows(INPUT_CODEWORDS));
    p_error_sc = bit_errors_corrected  / (repetitions * rows(INPUT_ALPHABET) * columns(INPUT_ALPHABET) );
    # We use ARQ, so the amount of total bits in error is smaller
    p_error_s  = bit_errors            / (repetitions * rows(INPUT_ALPHABET) * columns(INPUT_ALPHABET) - sum(word_errors_idx));

    eb_n0_channel(end+1) = EbN0;
    eb_n0_source(end+1)  = EbN0 + 10*log10(1/CODE_RATE);

    p_error_source(end+1) = p_error_s;
    p_error_source_corrected(end+1) = p_error_sc;
    p_error_word(end+1) = p_error_w;
    p_error_word_corrected(end+1) = p_error_wc;

    if p_error_w <= PE_LIMIT
        break
    end
end
toc();

save p2_1.mat
