source ej_2_common.m

# BPSK

bpsk_bits_noise = repmat(bpsk_bits, SYMBOLS, 1);
bpsk_bits_noise = bpsk_bits_noise'(:)';
bpsk_noise = addnoise(bpsk(bpsk_bits_noise), 10);
bpsk_noise_rotated  = ROTATE * bpsk_noise;
bpsk_coords_rotated = ROTATE * bpsk_coords;

figure();
hold on;
scatter(real(bpsk_noise_rotated),  imag(bpsk_noise_rotated), "b");
scatter(real(bpsk_coords), imag(bpsk_coords), 20, "r", "filled");
scatter(real(bpsk_coords_rotated), imag(bpsk_coords_rotated), 20, "g", "filled");
axis([-2 2 -2 2])
axis square;
grid on;
title('BPSK E_{B} / N_{0} = 10 dB con error de fase pi / 8')
xlabel ('Real');
ylabel ('Imag');
print -color -dsvg 'bpsk_250_ebno_10db_pi_8.svg'
hold off;


# QPSK

qpsk_bits_noise = repmat(qpsk_bits, SYMBOLS, 1);
qpsk_bits_noise = qpsk_bits_noise'(:)';
qpsk_noise = addnoise(qpsk(qpsk_bits_noise), 10);
qpsk_noise_rotated  = ROTATE * qpsk_noise;
qpsk_coords_rotated = ROTATE * qpsk_coords;

figure();
hold on;
scatter(real(qpsk_noise_rotated),  imag(qpsk_noise_rotated), "b");
scatter(real(qpsk_coords), imag(qpsk_coords), 20, "r", "filled");
scatter(real(qpsk_coords_rotated), imag(qpsk_coords_rotated), 20, "g", "filled");
axis([-3 3 -3 3])
axis square;
grid on;
title('QPSK E_{B} / N_{0} = 10 dB con error de fase pi / 8')
xlabel ('Real');
ylabel ('Imag');
print -color -dsvg 'qpsk_250_ebno_10db_pi_8.svg'
hold off;


# QAM16

qam16_bits_noise = repmat(qam16_bits, SYMBOLS, 1);
qam16_bits_noise = qam16_bits_noise'(:)';
qam16_noise = addnoise(qam16(qam16_bits_noise), 10, 4);
qam16_noise_rotated  = ROTATE * qam16_noise;
qam16_coords_rotated = ROTATE * qam16_coords;

figure();
hold on;
scatter(real(qam16_noise_rotated),  imag(qam16_noise_rotated), "b");
scatter(real(qam16_coords), imag(qam16_coords), 20, "r", "filled");
scatter(real(qam16_coords_rotated), imag(qam16_coords_rotated), 20, "g", "filled");
axis([-4 4 -4 4])
axis square;
grid on;
title('QAM16 E_{B} / N_{0} = 10 dB con error de fase pi / 8')
xlabel ('Real');
ylabel ('Imag');
print -color -dsvg 'qam16_250_ebno_10db_pi_8.svg'
hold off;

