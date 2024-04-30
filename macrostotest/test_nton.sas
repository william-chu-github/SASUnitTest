%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = NtoN, id = &TestID);
%test_describe(desc = NtoN test);
%test_expected(desc = %str(Determine if relationships between variables in a dataset are 1:1, 1:n, n:1, n:n));

/*
s/[a-z\d\(\)\' \-\.\,!\/&]//io
*/

data Raw;
input a b;
datalines;
1 1
2 2
2 3
3 4
4 4
5 5
5 6
6 6
;
run;

%NtoN(Raw, a, b, Result);

data Expect(drop = Part1 Part2);
length Part1 Part2 $1.;
input a b ID2Count ID1Count Part1 Part2;
* colon cannot be escaped in datalines? ;
RelationshipNN = Part1 || ":" || Part2;
datalines;
1 1 1 1 1 1
2 2 2 1 1 n
2 3 2 1 1 n
3 4 1 2 n 1
4 4 1 2 n 1
5 5 2 1 n n
5 6 2 2 n n
6 6 1 2 n n
;
run;


%assert_data_equal(ds1 = Result, ds2 = Expect);

%test_end();


