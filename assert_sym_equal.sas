%macro assert_sym_equal(sym1=, sym2=);
  %if %superq(sym1) eq %superq(sym2) %then %put RESULT: Pass;
  %else %put RESULT: Fail;
%mend assert_sym_equal;
