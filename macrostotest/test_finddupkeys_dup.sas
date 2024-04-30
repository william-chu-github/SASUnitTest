%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = FindDupKeys, id = &TestID);
%test_describe(desc = FindDupKeys test with duplicates);
%test_expected(desc = Output dataset should show the duplicated keys);

data Raw;
input x y;
datalines;
1 1
1 2
3 4
3 4
3 5
4 6
4 7
4 8
4 8
4 8
;
run;

%FindDupKeys(DS = Raw, Key = x y, OutDS = Result);
data Expect;
input x y Count;
datalines;
3 4 2
4 8 3
;
run;


%assert_data_equal(ds1 = Expect, ds2 = Result);

%test_end();
