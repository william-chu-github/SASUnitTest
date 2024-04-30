%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = CompareUniverse, id = &TestID);
%test_describe(desc = Test CompareUniverse macro for identical ID universes);
%test_expected(desc = Output dataset should be empty);

data ID1;
input a b;
datalines;
1 1
1 2
1 3
2 1
2 2
2 3
4 5
;
run;
data ID2;
input a b;
datalines;
1 1
1 2
1 2
1 3
2 1
2 2
2 2
2 2
2 3
;
run;

%CompareUniverse(ID1, ID2, a b, OutDS = Result);
data Expect;
a_1 = 4; b_1 = 5; a_2 = .; b_2 = .;
run;



%assert_data_equal(ds1 = Result, ds2 = Expect);

%test_end();
