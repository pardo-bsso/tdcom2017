function ret = qpsk_demod (symbols)
    re = real(symbols);
    im = imag(symbols);

    odd  = zeros(1, length(re));
    even = zeros(1, length(im));

    odd(re > 0) = 1;
    even(im > 0) = 1;

    len = length(even) + length(odd);
    ret = zeros(1, len);

    ret(1:2:len) = odd;
    ret(2:2:len) = even;
endfunction
