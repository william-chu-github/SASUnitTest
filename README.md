Implementation of a SAS unit testing framework for macros as introduced in [a 2013 PharmaSUG paper](https://www.pharmasug.org/proceedings/2013/AD/PharmaSUG-2013-AD09.pdf).

The root folder contains the framework macros/configurations and an example call (`UnitTestCaller.sas`). The folder `macrostotest` has example unit test files that the framework runs. They test some of the macros in [this repository](https://github.com/william-chu-github/SASMacros).

* `environment_config.sas` has settings which should be used with %include in the caller (see `UnitTestCaller.sas`)
    * the append options ensure the availability of the macros to be unit-tested, and the unit test framework macros (this repository)
    * `sasexe` is the path to the SAS executable
    * `SEARCH` is some regular expression text to extract problematic text from the logs (see the PharmaSUG paper)
    * `dir` gives the directory of macro unit tests (whose names start with "test_")
    * `work` is a directory to store the unit test logs
* `unittest_config.sas` has settings that the separate unit tests use
    * the append options ensure the framework macros are available, as well as the macros being unit-tested
    * the logging options shorten the log so the unit testing framework can easily scan them to get the test results
    * the `%sysget` call gets a test ID number from the calling macro to label the test number in the log
