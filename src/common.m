pkg load communications

# Cantidad de simbolos por esquema de modulacion.
SYMBOLS = 250;


# BPSK

bpsk_bits = [1 0];
bpsk_coords = bpsk([1 0]);
BPSK_BITS_PER_SYMBOL = 1;
BPSK_SYMBOLS = 4;


# QPSK

qpsk_bits = unique(nchoosek([1 0 1 0], 2), 'rows');
qpsk_bits = qpsk_bits'(:)';
qpsk_coords = qpsk(qpsk_bits);
QPSK_BITS_PER_SYMBOL = 2;
QPSK_SYMBOLS = 4;


# QAM16

# nchoosek blows here.
qam16_bits = [0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0 0 1 0 1 0 1 1 0 0 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 1 0 1 1 1 1 0 0 1 1 0 1 1 1 1 0 1 1 1 1];
qam16_coords = qam16(qam16_bits);
QAM16_BITS_PER_SYMBOL = 4;
QAM16_SYMBOLS = 4;
