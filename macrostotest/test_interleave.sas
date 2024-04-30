%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = Interleave, id = &TestID);
%test_describe(desc = Interleave test);
%test_expected(desc = Interleaves input space-separated words using the provided separator and interleaver);

%let Result = %Interleave(a b c d, 1 2 3 4, Separator = SEPARATOR, Interleaver = INTERLEAVER);

%assert_sym_equal(sym1 = aINTERLEAVER1SEPARATORbINTERLEAVER2SEPARATORcINTERLEAVER3SEPARATORdINTERLEAVER4, sym2 = &Result);

%test_end();


