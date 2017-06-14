source ej1_2_common.m

## Error probabilities for BPSK

## BPSK

BPSK_BITS_PER_SYMBOL = 1;
BPSK_SYMBOLS = 4;
bpsk_bits = [1 0];
bpsk_bits = repmat(bpsk_bits, SYMBOLS_ERROR / BPSK_SYMBOLS, 1);
bpsk_bits = bpsk_bits'(:)';
bpsk_symbols = bpsk(bpsk_bits);

bpsk_eb_n0 = [];
bpsk_p_error = [];
bpsk_p_error_theoric = [];

tic();
for EbN0 = EbN0_steps
    repetitions = 0;
    errors = 0;

    while errors < ERROR_COUNT_LIMIT
        repetitions += 1;
        bpsk_noisy_symbols = addnoise(bpsk_symbols, EbN0, BPSK_BITS_PER_SYMBOL);
        bpsk_noisy_bits = bpsk_demod(bpsk_noisy_symbols);
        errors += sum(bpsk_bits ~= bpsk_noisy_bits);
    end

    p_error = errors / (repetitions * SYMBOLS_ERROR * BPSK_BITS_PER_SYMBOL);
    bpsk_eb_n0(end+1) = EbN0;
    bpsk_p_error(end+1) = p_error;

    if p_error <= PE_LIMIT
        break
    end
end

bpsk_eb_n0_times = 10 .^ (bpsk_eb_n0 / 10);
bpsk_p_error_theoric = qfunc(sqrt(2*bpsk_eb_n0_times));

figure();
hold on;
semilogy(bpsk_eb_n0, bpsk_p_error_theoric, ';Teorico;');
semilogy(bpsk_eb_n0, bpsk_p_error, 'ko;Experimental;');
title('Perror BPSK')
xlabel ('E_{B} / N_{0} (dB)');
ylabel ('Perror');
grid on;
print -color -dsvg 'bpsk_p_error.svg'
hold off;
toc();


