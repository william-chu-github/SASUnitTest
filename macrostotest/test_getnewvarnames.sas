%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = GetNewVarNames, id = &TestID);
%test_describe(desc = GetNewVarNames test);
%test_expected(desc = Returns new variable names not already on a dataset and not in an exlusion list);

data DS;
X = 1; NEWNAME1 = 2;
run;

%let Result = %GetNewVarNames(DS, NumNames = 2, Exclusions = %str(NEWNAME2));

%assert_sym_equal(sym1 = NEWNAME3 NEWNAME4, sym2 = &Result);

%test_end();
