%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = GetNewDSNames, id = &TestID);
%test_describe(desc = GetNewDSNames test);
%test_expected(desc = Returns new dataset names not already in a library and not in an exlusion list);

data newds1;
X = 1; NEWNAME1 = 2;
run;

%let Result = %GetNewDSNames(NumNames = 2, NotAllowed = %str(NEWDS2));

%assert_sym_equal(sym1 = NEWDS3 NEWDS4, sym2 = &Result);

%test_end();
