## Common definitons for all the steps of ej2

pkg load communications;

# Process in batches of this many symbols until an error is found.
SYMBOLS_ERROR = 100 * 1000;

# Sweep parameters
EbN0_db_START = 0;
EbN0_db_END   = 20;
EbN0_db_STEP  = 1;
EbN0_steps = EbN0_db_START:EbN0_db_STEP:EbN0_db_END;

# Stop conditions
ERROR_COUNT_LIMIT = 100;
PE_LIMIT = 1e-5;
