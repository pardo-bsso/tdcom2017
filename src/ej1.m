# Cantidad de simbolos por esquema de modulacion.
SYMBOLS = 250;

# BPSK

bpsk_coords = bpsk([1 0]);
bpsk_noise = addnoise(bpsk([zeros(1, SYMBOLS) ones(1, SYMBOLS)]), 10);

figure();
hold on;
scatter(real(bpsk_noise),  imag(bpsk_noise), "b");
scatter(real(bpsk_coords), imag(bpsk_coords), 20, "r", "filled");
axis([-2 2 -2 2])
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
qpsk_noise = addnoise(qpsk(qpsk_bits_noise), 10, 2);

figure();
hold on;
scatter(real(qpsk_noise),  imag(qpsk_noise), "b");
scatter(real(qpsk_coords), imag(qpsk_coords), 20, "r", "filled");
axis([-3 3 -3 3])
grid on;
title('QPSK E_{B} / N_{0} = 10 dB')
xlabel ('Real');
ylabel ('Imag');
print -color -dsvg 'qpsk_250_ebno_10db.svg'
hold off;


# QAM16

# nchoosek blows here.
qam16_bits = [0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0 0 1 0 1 0 1 1 0 0 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 1 0 1 1 1 1 0 0 1 1 0 1 1 1 1 0 1 1 1 1];
qam16_coords = qam16(qam16_bits);

qam16_bits_noise = repmat(qam16_bits, SYMBOLS, 1);
qam16_bits_noise = qam16_bits_noise'(:)';
qam16_noise = addnoise(qam16(qam16_bits_noise), 10, 4);

figure();
hold on;
scatter(real(qam16_noise),  imag(qam16_noise), "b");
scatter(real(qam16_coords), imag(qam16_coords), 20, "r", "filled");
axis([-4 4 -4 4])
grid on;
title('QAM16 E_{B} / N_{0} = 10 dB')
xlabel ('Real');
ylabel ('Imag');
print -color -dsvg 'qam16_250_ebno_10db.svg'
hold off;


