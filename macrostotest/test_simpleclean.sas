%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = SimpleClean, id = &TestID);
%test_describe(desc = SimpleClean test);
%test_expected(desc = %nrstr(Modifies variable to be deaccented %(ligatures not changed%), left, upcase));

data Result;
x = "    ÈË…‡"; output;
x = "CLEAN"; output;
run;
data Result;
set Result;
%SimpleClean(x);
run;

data Expect;
length x $8.;
x = "EEEA "; output;
x = "CLEAN"; output;
run;

%assert_data_equal(ds1 = Expect, ds2 = Result);

%test_end();


