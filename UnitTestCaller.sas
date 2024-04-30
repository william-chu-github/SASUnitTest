%let environment = C:\Users\chuwill\Documents\SAS_Code\unittesting\environment_config.sas;

* have to include the run_all_tests macro so it can run here ;
%include "&environment";

%run_all_tests(
  environment = &environment,
  results = resultsds, 
  logscan = logscands
);
