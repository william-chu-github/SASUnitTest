* this macro will flag a fail if the formats of the compared datasets are unequal (e.g., length of string variables) ;
%macro assert_data_equal(
  ds1=, /* Data set one */
  ds2=, /* Data set two */
  id=, /* Optional: ID variables to align data sets */
  fuzz=0 /* Vars x and y are reported as identical if abs(x - y) <= &fuzz */
);
  %local Count1 Count2;
  %let Count1 = %CountObs(&ds1);
  %let Count2 = %CountObs(&ds2);
  %if ((&Count1 and &Count2) or (not &Count1 and not &Count2)) %then %do;
  proc compare base=&ds1 compare=&ds2 listall method=absolute criterion=&fuzz;
  %if &id ne %str() %then id &id;;
  run;
  %if &sysinfo = 0 %then %put RESULT: Pass;
    %else %put RESULT: Fail;
  %end;
  %else %put RESULT: Fail; %** Test fails for empty or missing data sets;
%mend assert_data_equal;
