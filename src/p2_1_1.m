pkg load communications
source p2_common.m

load p2_1.mat

bpsk_eb_n0_times_source  = 10 .^ (eb_n0_source  / 10);
bpsk_eb_n0_times_channel = 10 .^ (eb_n0_channel / 10);
p_bit_error_source  = qfunc(sqrt(2*bpsk_eb_n0_times_source));
p_bit_error_channel = qfunc(sqrt(2*bpsk_eb_n0_times_channel));

p_word_error_uncoded_theoric  = 1 - (1 - p_bit_error_source).^K;
p_word_error_coded_theoric    = zeros(1, length(p_bit_error_channel));
p_word_error_detected_theoric = zeros(1, length(p_bit_error_channel));

for idx = 1:length(p_bit_error_channel)
    p_e_channel = p_bit_error_channel(idx);
    p_e_source  = p_bit_error_source (idx);
    pe_w = 0;
    pd   = 0;
    for m = T:N
        pe_w = pe_w + nchoosek(N, m) * (p_e_channel^m) * ((1 - p_e_channel)^(N - m));
    end
    for m = (DMIN - 1):N
        pd   = pd   + nchoosek(N, m) * (p_e_source^m)  * ((1 - p_e_source)^(N - m));
    end
    p_word_error_coded_theoric(1, idx)    = pe_w;
    p_word_error_detected_theoric(1, idx) = pd;
end


figure();
hold on;
semilogy(eb_n0_channel, p_error_word_corrected,        '-o;Perror de palabra con codificación (experimental);');
semilogy(eb_n0_channel, p_word_error_coded_theoric,    'g;Perror con codificación (teorico);');
semilogy(eb_n0_source,  p_word_error_uncoded_theoric,  'r;Perror sin codificación (teorico);');
title('Perror palabra (corrector)')
xlabel ('E_{B} / N_{0} (dB)');
ylabel ('Perror');
grid on;
print -color -dsvg 'p_error_corrector95.svg'
hold off;


figure();
hold on;
semilogy(eb_n0_channel, p_error_word,                  '-o;Perror de detección con codificación (experimental);');
semilogy(eb_n0_channel, p_word_error_detected_theoric, 'r;Perror de detección con codificación (teorico);');
title('Perror bit (detector)')
xlabel ('E_{B} / N_{0} (dB)');
ylabel ('Perror');
grid on;
print -color -dsvg 'p_error_detector95.svg'
hold off;
