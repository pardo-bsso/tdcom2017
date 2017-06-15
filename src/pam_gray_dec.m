## Given a set of symbols as generated by pam_gray with minimum distance min_distance
## Returns the corresponding bitstream.
function ret = pam_gray_dec (symbols, min_distance=1);
    symbols_length = length(symbols);
    bitstream_odd  = zeros(1, symbols_length);
    bitstream_even = zeros(1, symbols_length);
    bitstream = zeros(1, symbols_length*2);

                                                    # Symbol  A  B
    bitstream_odd(symbols  >  2*min_distance) = 1;  #   +3    *
    bitstream_even(symbols >  2*min_distance) = 0;  #   +3       *
    bitstream_odd(symbols  < -2*min_distance) = 0;  #   -3    *
    bitstream_even(symbols < -2*min_distance) = 0;  #   -3       *

    idx_1     = (symbols > 0) & (symbols <= 2*min_distance);
    idx_min_1 = (symbols >= -2*min_distance) & (symbols < 0);
                                                    # Symbol  A  B
    bitstream_odd(idx_1)                      = 1;  #   +1    *
    bitstream_even(idx_1)                     = 1;  #   +1       *
    bitstream_odd(idx_min_1)                  = 0;  #   -1    *
    bitstream_even(idx_min_1)                 = 1;  #   -1       *

    bitstream(1:2:end) = bitstream_odd;
    bitstream(2:2:end) = bitstream_even;
    ret = bitstream;
endfunction