%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = GetVarNames, id = &TestID);
%test_describe(desc = GetVarNames test);
%test_expected(desc = Extracted variable names should be exactly the ones in the dataset);

data Raw;
length a b c d e f g 8.;
run;

%let VarNames = %GetVarNames(Raw);

%assert_sym_equal(sym1 = &VarNames, sym2 = a b c d e f g);

%test_end();
