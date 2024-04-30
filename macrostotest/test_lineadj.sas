%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = LineAdj, id = &TestID);
%test_describe(desc = LineAdj test);
%test_expected(desc = LineIDs with valid adjacency relationships are saved);

data Line;
infile datalines dsd dlm = " " missover;
input LineID Child_L Child_R;
datalines;
1 10 11
2  12
3 13 
4 14 15
5 14 15
6 15 14
7 16 17
;
run;

data Child;
input Child Parent;
datalines;
10 20
11 21
12 22
13 22
14 24
15 24
16 25
17 26
;
run;


%LineAdj(Line, Child, Child, Adj, Static = LineID);

data Expect;
input LineID Parent Parent_Adj;
datalines;
1 20 21
1 21 20
7 25 26
7 26 25
;
run;


%assert_data_equal(ds1 = Expect, ds2 = Adj);

%test_end();


