## Assumes bit energy == 1 and one bit per symbol by default.
function ret = addnoise (symbols, EbN0_db=3, bits_per_symbol=1)
    EbN0 = 10 ^ (EbN0_db / 10);
    EbN0 = EbN0 * bits_per_symbol;
    amplitude = 1 / sqrt(EbN0);

    re = real(symbols);
    im = imag(symbols);

    re = re + amplitude * randn(1, length(re));
    im = im + amplitude * randn(1, length(im));
    ret = re + 1j * im;
endfunction
