# Cantidad de simbolos por esquema de modulacion.
SYMBOLS = 250;
SYMBOLS = 10;

# BPSK

bpsk_coords = bpsk([1 0]);
bpsk_noise = addnoise(bpsk([zeros(1, SYMBOLS) ones(1, SYMBOLS)]), 10);

hold on;
scatter(real(bpsk_coords), imag(bpsk_coords), 20, "r", "filled");
scatter(real(bpsk_noise),  imag(bpsk_noise), "b");
grid on;
title('BPSK Eb_{N0} = 10 dB')
title('BPSK E_{B} / N_{0} = 10 dB')
xlabel ('Real');
ylabel ('Imag');
print -color -dsvg 'bpsk_250_ebno_10db.svg'
hold off;


# QPSK

qpsk_bits = unique(nchoosek([1  0 1 0], 2), 'rows');
qpsk_bits = qpsk_bits'(:)';
qpsk_coords = qpsk(qpsk_bits);

qpsk_bits_noise = repmat(qpsk_bits, SYMBOLS, 1);
qpsk_bits_noise = qpsk_bits_noise'(:)';
qpsk_noise = addnoise(qpsk(qpsk_bits_noise), 10);

figure();
hold on;
scatter(real(qpsk_coords), imag(qpsk_coords), 20, "r", "filled");
scatter(real(qpsk_noise),  imag(qpsk_noise), "b");
grid on;
title('QPSK Eb_{N0} = 10 dB')
title('QPSK E_{B} / N_{0} = 10 dB')
xlabel ('Real');
ylabel ('Imag');
print -color -dsvg 'qpsk_250_ebno_10db.svg'
hold off;



