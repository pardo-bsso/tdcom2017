# Assumes bit energy == 1 for now.
function ret = qam16_demod (symbols)
    A = sqrt(4) / sqrt(10);
    size_symbols = length(symbols);
    size_output  = size_symbols * 4;

    I = real(symbols);
    Q = imag(symbols);

    I_data = pam_gray_dec(I, A);
    Q_data = pam_gray_dec(Q, A);

    demod = zeros(1, size_output);
    demod(1:4:size_output) = I_data(1:2:end);
    demod(2:4:size_output) = I_data(2:2:end);
    demod(3:4:size_output) = Q_data(1:2:end);
    demod(4:4:size_output) = Q_data(2:2:end);

    ret = demod;
endfunction
