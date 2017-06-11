## Bits: [ A B C D ]
## [ A B ]: Quadrant
## [ C D ]: Position within quadrant.
##
##        01          ^    11
##                    |
##        01  |  11   |    01  |  11
##        ----+----   |    ----+----
##        00  |  10   |    00  |  10
##                    |
## -------------------|---------------->
##                    |
##        00          |    10
##                    |
##        01  |  11   |    01  |  11
##        ----+----   |    ----+----
##        00  |  10   |    00  |  10
##
## (energy per bit)
function ret = qam16 (bitstream, energy=1)
    bitstream_size = length(bitstream);

    # Bits [A B]
    quad_odd  = bitstream(1:4:bitstream_size);
    quad_even = bitstream(2:4:bitstream_size);

    # Bits [C D]
    pos_odd   = bitstream(3:4:bitstream_size);
    pos_even  = bitstream(4:4:bitstream_size);

    # Decompose process into a qpsk constellation offset by the quadrant position.
    # That offset (center) is also another qpsk constellation.

    # Make a temporary buffer, pad length to multiple of 2
    size_quad = length(quad_odd) + length(quad_even);
    size_quad = size_quad + mod(size_quad, 2);
    bitstream_quad = zeros(1, size_quad);

    bitstream_quad(1:2:size_quad) = quad_odd;
    bitstream_quad(2:2:size_quad) = quad_even;

    # For 16QAM with symbols at -3A, -A, A and 3A the average symbol energy is (A^2) / 10
    # So we want to have the new centers at +- 2/sqrt(10) and each quadrant constellation scaled by 1/sqrt(10)
    # This way the average symbol energy is 1. After merging the two we scale again by sqrt(4) to make the Bit energy equal to 1.

    offsets = qpsk(bitstream_quad);
    offsets = (2/sqrt(10)) .* offsets;

    # Make a temporary buffer, pad length to multiple of 2
    size_data = length(pos_odd) + length(pos_even);
    size_data = size_data + mod(size_data, 2);
    bitstream_data = zeros(1, size_data);

    bitstream_data(1:2:size_data) = pos_odd;
    bitstream_data(2:2:size_data) = pos_even;

    data = qpsk(bitstream_data);
    data = (1/sqrt(10)) .* data;

    ret = sqrt(4) .* (data + offsets);
endfunction

