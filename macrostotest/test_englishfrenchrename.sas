%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = EnglishFrenchRename, id = &TestID);
%test_describe(desc = EnglishFrenchRename test);
%test_expected(desc = Dataset has certain French variable names converted to English according to rules in macro);

data Result;
x = 3; y = 4; NOMFRA = "asdf";
run;
data Expect;
x = 3; y = 4; FRENAME = "asdf";
run;

%EnglishFrenchRenames(Result);

%assert_data_equal(ds1 = Expect, ds2 = Result);

%test_end();
