%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = CountObs, id = &TestID);
%test_describe(desc = Counting observations in dataset with 100 observations);
%test_expected(desc = Count should be 100);


data DS;
do i = 1 to 100;
  output;
end;
run;

%let Count = %CountObs(DS);


%assert_sym_equal(sym1 = &Count, sym2 = 100);

%test_end();
