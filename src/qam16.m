## Given Bits: [ A B C D ]
##
## Returns a QAM16 set of symbols with Gray mapping:
## A B      I     C D      Q
## 0 0     -3     0 0     -3
## 0 1     -1     0 1     -1
## 1 1     +1     1 1     +1
## 1 0     +3     1 0     +3
##
##
##                    ^
##                    |
##       0010 | 0110  |  1110 | 1010
##       -----+-----  |  -----+-----
##       0010 | 0111  |  1111 | 1011
##                    |
## -------------------|---------------->
##                    |
##       0001 | 0101  |  1101 | 1001
##       -----+-----  |  -----+-----
##       0000 | 0100  |  1100 | 1000
##
## (energy per bit)
function ret = qam16 (bitstream, energy=1)
    bitstream_size = length(bitstream);

    if (mod(bitstream_size, 2) ~= 0)
        bitstream(end+1) = 0;
        bitstream_size = length(bitstream);
    end

    data_I = zeros(1, bitstream_size / 2);
    data_Q = zeros(1, bitstream_size / 2);

    # Bits [A B]
    quad_odd  = bitstream(1:4:bitstream_size);
    quad_even = bitstream(2:4:bitstream_size);
    data_I(1:2:end) = bitstream(1:4:end);
    data_I(2:2:end) = bitstream(2:4:end);

    # Bits [C D]
    data_Q(1:2:end) = bitstream(3:4:end);
    data_Q(2:2:end) = bitstream(4:4:end);

    I = pam_gray(data_I);
    Q = 1j * pam_gray(data_Q);

    # For 16QAM with symbols at -3A, -A, A and 3A the average symbol energy is (A^2) / 10
    # So we want each component scaled by 1/sqrt(10)
    # This way the average symbol energy is 1. Then we scale again by sqrt(4) to make the Bit energy equal to 1.

    ret = sqrt(4/10) * (I + Q);
endfunction

