%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = CreateCompositeKeys, id = &TestID);
%test_describe(desc = CreateCompositeKeys test);
%test_expected(desc = Reduce multivariable block/adjacency relationships to a single sequential variable);

/*
s/[a-z\d\(\)\' \-\.\,!\/&]//io
*/

data RawBlock;
input a b;
datalines;
1 1
1 2
2 1
2 2
2 2
2 3
3 4
;
run;

data RawAdj;
input a b a_adj b_adj;
datalines;
1 1 1 2
1 2 1 1
1 2 2 1
2 1 1 2
2 1 2 2
2 2 2 1
2 3 3 4
3 4 2 3
;
run;

data ExpectBlock;
input a b NewKey;
datalines;
1 1 1
1 2 2
2 1 3
2 2 4
2 3 5
3 4 6
;
run;

data ExpectAdj;
input a b a_adj b_adj NewKey NewKey_adj;
datalines;
1 1 1 2 1 2
1 2 1 1 2 1
1 2 2 1 2 3
2 1 1 2 3 2
2 1 2 2 3 4
2 2 2 1 4 3
2 3 3 4 5 6
3 4 2 3 6 5
;
run;

%CreateCompositeKeys(RawAdj, RawBlock, a b, KeyName = NewKey);

%let CountBlock = 0;
%let CountAdj = 0;
proc sql noprint;
create table BlockMismatch as
  select distinct RawBlock.a
    from RawBlock full join ExpectBlock
    on RawBlock.a = ExpectBlock.a and RawBlock.b = ExpectBlock.b and RawBlock.NewKey = ExpectBlock.NewKey
    where RawBlock.a is missing or ExpectBlock.a is missing or
          RawBlock.b is missing or ExpectBlock.b is missing or
          RawBlock.NewKey is missing or ExpectBlock.NewKey is missing;
select count(*) into :CountBlock from BlockMismatch;
create table AdjMismatch as
  select distinct RawAdj.a
    from RawAdj full join ExpectAdj
    on RawAdj.a = ExpectAdj.a and RawAdj.b = ExpectAdj.b and RawAdj.NewKey = ExpectAdj.NewKey and
       RawAdj.a_adj = ExpectAdj.a_adj and RawAdj.b_adj = ExpectAdj.b_adj and RawAdj.NewKey_adj = ExpectAdj.NewKey_adj
    where RawAdj.a is missing or ExpectAdj.a is missing or RawAdj.b is missing or ExpectAdj.b is missing or
          RawAdj.NewKey is missing or ExpectAdj.NewKey is missing or
          RawAdj.a_adj is missing or ExpectAdj.a_adj is missing or RawAdj.b_adj is missing or ExpectAdj.b_adj is missing or
          RawAdj.NewKey_adj is missing or ExpectAdj.NewKey_adj is missing;
select count(*) into :CountAdj from AdjMismatch;
quit;
run;

%let Result = %eval(not &CountBlock and not &CountAdj);

%assert_sym_equal(sym1 = &Result, sym2 = 1);

%test_end();


