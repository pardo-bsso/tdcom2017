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

    size_quad = max(length(quad_odd), length(quad_even));
    bitstream_quad = zeros(1:size_quad)

    bitstream_quad(1:2:size_quad) = quad_odd;
    bitstream_quad(2:2:size_quad) = quad_even;

    offsets = qpsk(bitstream_quad);

# For 16QAM with symbols at -3A, -A, A and 3A the average symbol energy is
# (1/4) * (  )
    ret = 0; # XXX FIXME.
endfunction

