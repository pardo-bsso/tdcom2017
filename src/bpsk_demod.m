function ret = bpsk_demod (symbols)
    ret = symbols;
    ret(ret > 0) = 1;
    ret(ret < 0) = 0;
endfunction
