source ej1_2_common.m

## Error probabilities for QPSK

## QPSK

QPSK_BITS_PER_SYMBOL = 2;
QPSK_SYMBOLS = 4;
qpsk_bits = [0 0 0 1 1 0 1 1];
qpsk_bits = repmat(qpsk_bits, SYMBOLS_ERROR / QPSK_SYMBOLS, 1);
qpsk_bits = qpsk_bits'(:)';
qpsk_symbols = qpsk(qpsk_bits);

qpsk_eb_n0 = [];
qpsk_p_error = [];
qpsk_p_error_theoric = [];

tic();
for EbN0 = EbN0_steps
    repetitions = 0;
    errors = 0;

    while errors < ERROR_COUNT_LIMIT
        repetitions += 1;
        qpsk_noisy_symbols = addnoise(qpsk_symbols, EbN0, QPSK_BITS_PER_SYMBOL);
        qpsk_noisy_bits = qpsk_demod(qpsk_noisy_symbols);
        errors += sum(qpsk_bits ~= qpsk_noisy_bits);
    end

    p_error = errors / (repetitions * SYMBOLS_ERROR * QPSK_BITS_PER_SYMBOL);
    qpsk_eb_n0(end+1) = EbN0;
    qpsk_p_error(end+1) = p_error;

    if p_error <= PE_LIMIT
        break
    end
end

qpsk_eb_n0_times = 10 .^ (qpsk_eb_n0 / 10);
qpsk_p_error_theoric = qfunc(sqrt(2*qpsk_eb_n0_times));

figure();
hold on;
semilogy(qpsk_eb_n0, qpsk_p_error_theoric, ';Teorico;');
semilogy(qpsk_eb_n0, qpsk_p_error, 'ko;Experimental;');
title('Perror QPSK')
xlabel ('E_{B} / N_{0} (dB)');
ylabel ('Perror');
grid on;
print -color -dsvg 'qpsk_p_error.svg'
hold off;
toc();
