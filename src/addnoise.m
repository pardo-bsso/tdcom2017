## Assumes bit energy == 1 and one bit per symbol by default.
function ret = addnoise (symbols, EbN0_db=3)
    EbN0 = 10 ^ (EbN0_db / 10);
    amplitude = 1 / sqrt(2*EbN0);

    re = real(symbols);
    im = imag(symbols);

    re = re + amplitude * randn(rows(re), columns(re));
    im = im + amplitude * randn(rows(im), columns(im));
    ret = re + 1j * im;
endfunction
