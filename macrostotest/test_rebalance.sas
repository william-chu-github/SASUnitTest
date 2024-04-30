%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = Rebalance, id = &TestID);
%test_describe(desc = Rebalance test);
%test_expected(desc = Rounded counts are adjusted so they sum to the aggregate count at the parent level);

data Result;
length child $1.;
input child parent source1 source2 rebal1 rebal2;
datalines;
1 11 50 3 25 1
2 11 50 3 25 1
3 12 33 5 16 3
4 12 33 5 7 1
5 12 33 5 7 1
6 13 25 7 25 7
;
run;

%Rebalance(result, result2, source1 source2, rebal1 rebal2, parent);

data Expect;
length child $1.;
input child parent source1 source2 rebal1 rebal2;
datalines;
1 11 50 3 25 2
2 11 50 3 25 1
3 12 33 5 19 3
4 12 33 5 7 1
5 12 33 5 7 1
6 13 25 7 25 7
;
run;


%assert_data_equal(ds1 = Expect, ds2 = Result2);

%test_end();
