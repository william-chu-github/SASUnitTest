%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = Separate, id = &TestID);
%test_describe(desc = Separate test);
%test_expected(desc = Separates input space-separated words using the provided separator);

%let Result = %Separate(a b c d, Separator = |);

%assert_sym_equal(sym1 = a|b|c|d, sym2 = &Result);

%test_end();


