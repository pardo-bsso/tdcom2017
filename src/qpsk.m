##        ^
##    01  |   11
##--------+------->
##    00  |   10
##
## (energy per bit)
function ret = qpsk (bitstream, energy=1)
    amplitude = sqrt(energy);
    even = bitstream(2:2:length(bitstream));
    odd  = bitstream(1:2:length(bitstream));

    real = amplitude * bpsk(odd);
    imag = 1j * amplitude * bpsk(even);
    ret = real + imag;
endfunction

