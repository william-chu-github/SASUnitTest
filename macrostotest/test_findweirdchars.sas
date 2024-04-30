%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = FindWeirdChars, id = &TestID);
%test_describe(desc = FindWeirdChars test);
%test_expected(desc = Find characters in standardised string variables which are out of ordinary);

/*
s/[a-z\d\(\)\' \-\.\,!\/&]//io
*/

data Raw;
length line $20.;
input line;
datalines4;
é-.!&()987Bah,
el+;?m
;;;;
run;

%FindWeirdChars(Raw, Result);

data Expect;
length VarName $32. Char $20.;
input VarName Char;
datalines4;
line +
line ;
line ?
;;;;
run;

%assert_data_equal(ds1 = Expect, ds2 = Result);

%test_end();


