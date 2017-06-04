function ret = bpsk (bitstream, energy=1)
    amplitude = sqrt(energy);
    ret = amplitude * (2*bitstream -1);
endfunction
