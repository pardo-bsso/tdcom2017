## Assumes bit energy == 1
function ret = addnoise (symbols, EbN0_db=3)
    EbN0 = 10 ^ (EbN0_db / 10);
    amplitude = 1 / sqrt(EbN0);

    re = real(symbols);
    im = imag(symbols);

    re = re + amplitude * randn(1, length(re));
    im = im + amplitude * randn(1, length(im));
    ret = re + 1j * im;
endfunction
