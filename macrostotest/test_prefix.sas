%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = Prefix, id = &TestID);
%test_describe(desc = Prefix test);
%test_expected(desc = Returns macro text with each element prefixed);

%let Result = %Prefix(a b c, _);

%assert_sym_equal(sym1 = &Result, sym2 = _a _b _c);

%test_end();
