%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = Deformat, id = &TestID);
%test_describe(desc = Removing formats/informats/labels from list of datasets);
%test_expected(desc = Datasets should have empty formats/informats/labels);

data z1;
x = 2;
format x 9.4;
informat x 9.4;
label x = "x variable";
run;

data z2;
x = 2;
format x 9.4;
informat x 9.4;
label x = "x variable";
run;

%Deformat(Tabs = z1 z2);

%let Formats1 = 0;
%let Formats2 = 0;

proc contents data = z1 out = z1 noprint; run;
proc contents data = z2 out = z2 noprint; run;

proc sql noprint;
select count(*) into :Formats1 from z1 where label or format or informat;
select count(*) into :Formats2 from z2 where label or format or informat;
quit;
run;
%let Formats = %sysevalf(&Formats1 + &Formats2);

%assert_sym_equal(sym1 = &Formats, sym2 = 0);

%test_end();
