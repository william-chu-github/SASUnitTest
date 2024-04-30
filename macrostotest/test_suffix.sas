%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = Suffix, id = &TestID);
%test_describe(desc = Suffix test);
%test_expected(desc = Returns macro text with each element suffixed);

%let Result = %Suffix(a b c, _);

%assert_sym_equal(sym1 = &Result, sym2 = a_ b_ c_);

%test_end();
