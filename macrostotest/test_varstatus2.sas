%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = VarStatus2, id = &TestID);
%test_describe(desc = VarStatus2 test);
%test_expected(desc = Variables2 correctly flagged as numeric-character-all missing-partially populated-etc);


data Raw;
length char1 char2 char3 $1.;
input num1 num2 num3 char1 char2 char3;
datalines;
0 . 1 0 . 1
2 . 2 2 . 2
3 . 2 3 . 2
4 . . 4 . .
5 . . 5 . .
6 . . 6 . .
;
run;

%VarStatus2(Raw);

data Expect;
length VarName $32. VarStatus $20.;
infile cards dsd missover dlm = " ";
input VarName VarStatus NumZero NumMiss NumUnique NumRecs;
datalines;
char1 "Totally Populated" 0 0 6 6
char2 "Unpopulated" 0 6 0 6
char3 "Partially Populated" 0 3 2 6
num1 "Totally Populated" 1 0 6 6
num2 "Unpopulated" 0 6 0 6
num3 "Partially Populated" 0 3 2 6
;
run;

%assert_data_equal(ds1 = Expect, ds2 = Raw_Pop);

%test_end();


