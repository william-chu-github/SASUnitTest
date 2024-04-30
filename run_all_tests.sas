/* 
multiple asserts in the test file are ignored--only the last case is output to the results file

what happens if there is some sort of error that cuts off the log before it can output the test completed
log note? there is no end test line in the log and the test is not recorded at all

would be nice to have a more detailed failure message

*/



%macro run_all_tests(
  environment=,
  results=,
  logscan=
);
%include "&environment";
filename dref "&dir";
data
  &results (keep=unit id file desc expect result)
  &logscan (keep=file linenum line syscc)
;
length file log line $200 dref unit id result $32 desc expect $5000;
dref = "dref";
dirid = dopen(dref);
if dirid <= 0 then do;
  put "ERROR: Directory &dir could not be opened";
end;
else do i=1 to dnum(dirid); ** READ ALL FILES IN THE DIRECTORY;
  ** READ FILE NAME (SKIPPING NON-TEST FILES);
  ** READ FILE NAME (SKIPPING NON-TEST FILES);
  file = dread(dirid, i);
  if prxmatch('/^TEST_.*\.SAS$/i', strip(file)) = 0 then continue;
  ** EXECUTE TEST PROGRAM. THE LOG IS WRITTEN TO THE WORK DIRECTORY;
  log = cats("&work\", scan(file, 1, '.'), ".log");
  syscc = system(
    '"' || "&sasexe" || '" -rsasuser ' ||
    "-log " || '"' || strip(log) || '" ' ||
    "-set TestID " || trim(put(i, 8.)) || " " ||
    "-sysin " || '"' || "&dir\" || strip(scan(file, 1, ".")) || '"');
  logfail = 0; ** INITIALIZE LOG STATUS;
  if fileexist(log)=0 then do;
    put "ERROR: Log does not exist: " log=;
  end;
  else do linenum=1 by 1 until(eof); ** READ ALL LINES IN THE LOG;
    infile logref end=eof filevar=log truncover dlm=':';
    input part1 : $upcase200. part2 $200.; ** READ LINE IN TWO PARTS;
    line = compress(catx(': ', part1, part2), , 'c');
    ** SEARCH FOR TEST RESULTS AND LOG PROBLEMS;
    if part1 = 'TEST' then do;
      unit = left(scan(right(part2), 1, '[]'));
      id = left(scan(right(part2), 2, '[]'));
    end;
    else if part1 = 'DESC' then desc = catx(' ', desc, part2);
    else if part1 = 'EXPECT' then expect = catx(' ', expect, part2);
    else if part1 = 'RESULT' then do;
/* what the heck does this do? */
      /*
      resultn = max(input(upcase(part2), result.), resultn);
      result = put(resultn, result.);*/
      result = upcase(part2);
    end;
    else if part1 = 'ENDTEST' then output &results;
    else if prxmatch(cats("/&search/i"), line) > 0 then do;
      logfail+1;
      output &logscan;
    end;
    ** AT THE END OF THE LOG, INDICATE IF CLEAN;
    if eof and logfail < 1 then do;
      line = "Clean";
      output &logscan;
    end;
/* !!! no logscan for dirty log? */
    ** RESET VARIABLES;
    if eof or part1='ENDTEST' then do;
      call missing(unit, id, desc, expect, of result:);
    end;
  end; ** LOOP OVER LINES IN THE LOG;
end; ** LOOP OVER ALL FILES;
** CLOSE DIRECTORY AND STOP THE DATA STEP;
status = dclose(dirid);
stop;
run;
%** SAVE TEMP LOG/LST;
filename dref clear;
%mend run_all_tests;

