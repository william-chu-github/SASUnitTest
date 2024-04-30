%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = FindDupKeys, id = &TestID);
%test_describe(desc = FindDupKeys test with no duplicates);
%test_expected(desc = Dataset should be empty/zero count);

data Raw;
input x y;
datalines;
1 2
1 3
4 5
4 6
7 8
9 10
;
run;

%FindDupKeys(DS = Raw, Key = x y, OutDS = Result);
%let Count = 0;
proc sql noprint;
select count(*) into :Count from Result;
quit;
run;

%assert_sym_equal(sym1 = &Count, sym2 = 0);

%test_end();
