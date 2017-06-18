source ej1_2_common.m
source ej_2_common.m

## Error probabilities for QPSK with phase error.

## QPSK

qpsk_bits = [0 0 0 1 1 0 1 1];
qpsk_bits = repmat(qpsk_bits, SYMBOLS_ERROR / QPSK_SYMBOLS, 1);
qpsk_bits = qpsk_bits'(:)';
qpsk_symbols = ROTATE * qpsk(qpsk_bits);

qpsk_eb_n0 = [];
qpsk_p_error = [];
qpsk_p_error_theoric = [];

tic();
for EbN0 = EbN0_steps
    repetitions = 0;
    errors = 0;

    while errors < ERROR_COUNT_LIMIT
        repetitions += 1;
        qpsk_noisy_symbols = addnoise(qpsk_symbols, EbN0);
        qpsk_noisy_bits = qpsk_demod(qpsk_noisy_symbols);
        errors += sum(qpsk_bits ~= qpsk_noisy_bits);
    end

    p_error = errors / (repetitions * length(qpsk_bits));
    qpsk_eb_n0(end+1) = EbN0;
    qpsk_p_error(end+1) = p_error;

    if p_error <= PE_LIMIT
        break
    end
end

qpsk_eb_n0_times = 10 .^ (qpsk_eb_n0 / 10);
qpsk_p_error_theoric = qfunc(sqrt(2*qpsk_eb_n0_times*(sin(THETA)^2)));

figure();
hold on;
semilogy(qpsk_eb_n0, qpsk_p_error_theoric, ';Teorico (cota superior);');
semilogy(qpsk_eb_n0, qpsk_p_error, 'ko;Experimental;');
title('Perror QPSK con error de fase pi / 8')
xlabel ('E_{B} / N_{0} (dB)');
ylabel ('Perror');
grid on;
print -color -dsvg 'qpsk_p_error_pi_8.svg'
hold off;
toc();
