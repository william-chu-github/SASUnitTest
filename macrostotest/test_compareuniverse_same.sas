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


* proc compare giving a warning with comparing empty datasets, so check if empty and has the four columns ;
proc contents data = Result out = Contents(keep = NAME) noprint; run;
data Expect;
input NAME $3.;
datalines;
a_1
b_1
a_2
b_2
;
run;
%let Count = 0;
%let Mismatch = 0;
proc sql noprint;
create table Mismatch as
  select Contents.NAME, Expect.NAME as NAME2
    from Contents full join Expect
    on Contents.NAME = Expect.NAME
    where Contents.NAME is missing or Expect.NAME is missing;
select count(*) into :Mismatch from Mismatch;
select count(*) into :Count from Result;
quit;
run;

%let Result = %eval((&Count = 0) and (&Mismatch = 0));

%assert_sym_equal(sym1 = 1, sym2 = &Result);

%test_end();
