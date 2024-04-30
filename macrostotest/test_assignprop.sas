%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = AssignProp, id = &TestID);
%test_describe(desc = AssignProp test);
%test_expected(desc = Units are assigned as proportionally as possible to blocks while respecting structures);

* approx 70% of units on street 1 should be in block 1, and 30% in block 2 ;
data PROPDS;
input block street frac;
datalines;
1     1      0.7
1     2      0.5
2     1      0.3
3     2      0.5
;
run;

* struct 4 is on street 3, which is not on the proportion file, so ignored ;
data STRUCTDS;
input structid units street;
datalines;
1        50    1
2        20    2
3        5     1
4        15    3
;
run;

data Expect;
input structid block;
datalines;
1 1
2 1
3 2
;
run;


%AssignProp(STRUCTDS, PROPDS, structid, units, frac, street, block, Result, ShowCounts = 0);

%assert_data_equal(ds1 = Expect, ds2 = Result);

%test_end();
