G = [ 1 0 0 0 0 0 0 1 1 ;
      0 1 0 0 0 0 1 0 1 ;
      0 0 1 0 0 0 1 1 0 ;
      0 0 0 1 0 0 1 1 1 ;
      0 0 0 0 1 1 0 0 1 ];

H = [ 0 0 0 0 1 1 0 0 0 ;
      0 1 1 1 0 0 1 0 0 ;
      1 0 1 1 0 0 0 1 0 ;
      1 1 0 1 1 0 0 0 1 ];

input_alphabet = [ 0, 0, 0, 0, 0 ;
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

# Process in batches of this many alphabets until an error is found.
ALPHABETS_ERROR = 100 * 1000;

# Sweep parameters
EbN0_db_START = 0;
EbN0_db_END   = 20;
EbN0_db_STEP  = 1;
EbN0_steps = EbN0_db_START:EbN0_db_STEP:EbN0_db_END;

# Stop conditions
ERROR_COUNT_LIMIT = 100;
PE_LIMIT = 1e-5;

INPUT_ALPHABETS = repmat(input_alphabet, ALPHABETS_ERROR, 1);
BPSK_SYMBOLS = bpsk(INPUT_ALPHABETS);
