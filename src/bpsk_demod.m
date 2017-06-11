function ret = bpsk_demod (symbols)
    ret = symbols;
    ret(real(ret) > 0) = 1;
    ret(real(ret) < 0) = 0;
endfunction
