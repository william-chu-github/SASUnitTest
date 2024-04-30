%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = CountObs, id = &TestID);
%test_describe(desc = Counting observations in empty dataset);
%test_expected(desc = Count should be zero);


data DS;
a = .;
delete;
run;

%let Count = %CountObs(DS);


%assert_sym_equal(sym1 = &Count, sym2 = 0);

%test_end();
