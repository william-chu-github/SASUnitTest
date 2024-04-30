%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = AssignProportional, id = &TestID);
%test_describe(desc = AssignProportional test for rounding without sum correction);
%test_expected(desc = Units are assigned as proportionally from parent to child using given proportions);



data Parent;
length Parent $1.;
input Parent Source1 Source2;
datalines;
1 50 51
2 0 30
3 19 0
;
run;

data Child;
length Parent Aux $1.;
input Parent Child Aux Proportion;
datalines;
1 10 A 0.5
1 11 B 0.5
2 12 C 0.333
2 13 D 0.333
2 14 E 0.333
3 15 F 0.25
3 16 G 0.25
3 17 H 0.25
3 18 I 0.25
;
run;


data Expect;
length Parent $1.;
input Parent Child Source1 Source2;
datalines;
1 10 25 25.5
1 11 25 25.5
2 12 0 10
2 13 0 10
2 14 0 10
3 15 4.75 0
3 16 4.75 0
3 17 4.75 0
3 18 4.75 0
;
run;


%AssignProportional(Parent, Child, Result, Parent, Child, Source1 Source2, Proportion, 0);


%assert_data_equal(ds1 = Expect, ds2 = Result);


%test_end();
