source ej1_2_common.m

## Error probabilities for QAM16

## QAM16

QAM16_BITS_PER_SYMBOL = 4;
QAM16_SYMBOLS = 4;
qam16_bits = [0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0 0 1 0 1 0 1 1 0 0 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 1 0 1 1 1 1 0 0 1 1 0 1 1 1 1 0 1 1 1 1];
qam16_bits = repmat(qam16_bits, SYMBOLS_ERROR / QAM16_SYMBOLS, 1);
qam16_bits = qam16_bits'(:)';
qam16_symbols = qam16(qam16_bits);

qam16_eb_n0 = [];
qam16_p_error = [];
qam16_p_error_theoric = [];

tic();
for EbN0 = EbN0_steps
    repetitions = 0;
    errors = 0;

    while errors < ERROR_COUNT_LIMIT
        repetitions += 1;
        qam16_noisy_symbols = addnoise(qam16_symbols, EbN0, QAM16_BITS_PER_SYMBOL);
        qam16_noisy_bits = qam16_demod(qam16_noisy_symbols);
        errors += sum(qam16_bits ~= qam16_noisy_bits);
    end

    p_error = errors / (repetitions * SYMBOLS_ERROR * QAM16_BITS_PER_SYMBOL);
    qam16_eb_n0(end+1) = EbN0;
    qam16_p_error(end+1) = p_error;

    if p_error <= PE_LIMIT
        break
    end
end

qam16_eb_n0_times = 10 .^ (qam16_eb_n0 / 10);
M = 16;
sqrt_M = sqrt(M);
log2_M = log2(M);

# Approximation.
# qam16_p_error_theoric = ((4*(sqrt_M - 1))/ (sqrt_M * log2_M)) * qfunc(sqrt(qam16_eb_n0_times .* (3*log2_M / (M-1))));

# Exact.
qam16_p_error_theoric = 1 - (1 - (2*(sqrt_M - 1)/sqrt_M)*qfunc(sqrt((3*4.*qam16_eb_n0_times)/(M-1))));


figure();
hold on;
semilogy(qam16_eb_n0, qam16_p_error_theoric, ';Teorico;');
semilogy(qam16_eb_n0, qam16_p_error, 'ko;Experimental;');
title('Perror QAM16')
xlabel ('E_{B} / N_{0} (dB)');
ylabel ('Perror');
grid on;
print -color -dsvg 'qam16_p_error.svg'
hold off;
toc();
