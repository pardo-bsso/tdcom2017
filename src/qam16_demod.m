# Assumes bit energy == 1 for now.
function ret = qam16_demod (symbols)
    A = sqrt(4) / sqrt(10);
    size_symbols = length(symbols);
    size_output  = size_symbols * 4;

    re = real(symbols);
    im = imag(symbols);

    offsets    = zeros(1, size_symbols);
    offsets_re = zeros(1, size_symbols);
    offsets_im = zeros(1, size_symbols);

    offsets_re(re > 0) = 2*A;
    offsets_re(re < 0) = -2*A;
    offsets_im(im > 0) = + 2j*A;
    offsets_im(im < 0) = -2j*A;
    offsets = offsets_re + offsets_im;

    quad = qpsk_demod(offsets);
    quad_size = length(quad);
    data = qpsk_demod(symbols - offsets);

    demod = zeros(1, size_output);
    demod(1:4:size_output) = quad(1:2:quad_size);
    demod(2:4:size_output) = quad(2:2:quad_size);
    demod(3:4:size_output) = data(1:2:quad_size);
    demod(4:4:size_output) = data(2:2:quad_size);

    ret = demod;
endfunction
