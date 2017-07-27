global G = [ 1 0 0 0 0 0 0 1 1 ;
      0 1 0 0 0 0 1 0 1 ;
      0 0 1 0 0 0 1 1 0 ;
      0 0 0 1 0 0 1 1 1 ;
      0 0 0 0 1 1 0 0 1 ];

global H = [ 0 0 0 0 1 1 0 0 0 ;
      0 1 1 1 0 0 1 0 0 ;
      1 0 1 1 0 0 0 1 0 ;
      1 1 0 1 1 0 0 0 1 ];

global input_alphabet = [ 0, 0, 0, 0, 0 ;
                   0, 0, 0, 0, 1 ;
                   0, 0, 0, 1, 0 ;
                   0, 0, 0, 1, 1 ;
                   0, 0, 1, 0, 0 ;
                   0, 0, 1, 0, 1 ;
                   0, 0, 1, 1, 0 ;
                   0, 0, 1, 1, 1 ;
                   0, 1, 0, 0, 0 ;
                   0, 1, 0, 0, 1 ;
                   0, 1, 0, 1, 0 ;
                   0, 1, 0, 1, 1 ;
                   0, 1, 1, 0, 0 ;
                   0, 1, 1, 0, 1 ;
                   0, 1, 1, 1, 0 ;
                   0, 1, 1, 1, 1 ;
                   1, 0, 0, 0, 0 ;
                   1, 0, 0, 0, 1 ;
                   1, 0, 0, 1, 0 ;
                   1, 0, 0, 1, 1 ;
                   1, 0, 1, 0, 0 ;
                   1, 0, 1, 0, 1 ;
                   1, 0, 1, 1, 0 ;
                   1, 0, 1, 1, 1 ;
                   1, 1, 0, 0, 0 ;
                   1, 1, 0, 0, 1 ;
                   1, 1, 0, 1, 0 ;
                   1, 1, 0, 1, 1 ;
                   1, 1, 1, 0, 0 ;
                   1, 1, 1, 0, 1 ;
                   1, 1, 1, 1, 0 ;
                   1, 1, 1, 1, 1 ];

global CODEWORDS = mod(input_alphabet * G, 2);

N = 9;
K = 5;
DMIN = 3;
T = 1;
CODE_RATE = K / N;


# Process in batches of this many alphabets until an error is found.
ALPHABETS_ERROR = 10;

# Sweep parameters
EbN0_db_START = 0;
EbN0_db_END   = 10;
EbN0_db_STEP  = 1;
EbN0_steps = EbN0_db_START:EbN0_db_STEP:EbN0_db_END;

# Stop conditions (tweaked a little so the script doesn't take forever to complete)
CORRECTED_WORD_ERROR_COUNT_LIMIT = 40;
PE_LIMIT = 2e-5;

INPUT_ALPHABET  = repmat(input_alphabet, ALPHABETS_ERROR, 1);
INPUT_CODEWORDS = repmat(CODEWORDS,      ALPHABETS_ERROR, 1);
BPSK_SYMBOLS = bpsk(INPUT_CODEWORDS);

# Corrects errors in a set of words with (9,5) code with generator and parity matrixes defined in p2_common using ML criteria.
# Assumes one word per row
function ret = correct_95 (codewords)
    global H;
    global CODEWORDS;

    syndromes = mod(codewords * H', 2);
    errors    = sum(syndromes ~= [0 0 0 0], 2);

    for idx = 1:length(errors)
        if (errors(idx) == 0)
            continue
        end

        distances = sum( mod((codewords(idx, 1:end) .- CODEWORDS), 2) , 2);
        corrected = CODEWORDS(distances == min(distances), 1:end);
        codewords(idx, 1:end) = corrected(1, :);
    end
    ret = codewords;
endfunction

# Decodes set of words with (9,5) code with generator and parity matrixes defined in p2_common using ML criteria.
# Assumes one word per row
function ret = decode_95 (codewords)
    global H;
    global CODEWORDS;
    global input_alphabet;

    decoded = zeros(rows(codewords), 5);

    for idx = 1:rows(codewords)
        distances = sum( mod((codewords(idx, 1:end) .- CODEWORDS), 2) , 2);
        probable_words = input_alphabet(distances == min(distances), 1:end);
        decoded(idx, 1:end) = probable_words(1, :);
    end
    ret = decoded;
endfunction
