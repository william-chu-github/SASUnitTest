%include "C:\Users\chuwill\Documents\sas_code\unittesting\unittest_config.sas";

* id should be parametrised... ;
%test_begin(unit = Cluster, id = &TestID);
%test_describe(desc = Cluster test);
%test_expected(desc = Clusters blocks while respecting HLGs... ax to a1 and bx to b1);

/*

diagram to make test data

col1 col2 col3 col4   <-lines
=----+----+----+ row1
| a1 | a2 | b1 |
=----+----+----+ row2
| a4 | a3 | b2 |
=----+----+----+ row3


*/

data Line;
infile datalines dsd dlm = " " missover;
length LineID $3. Child_L Child_R $2.;
input LineID Child_L Child_R;
datalines;
c11  a1
c12  a4
c21 a1 a2
c22 a4 a3
c31 a2 b1
c32 a3 b2
c41 b1 
c42 b2 
r11  a1
r12  a2
r13  b1
r21 a1 a4
r22 a2 a3
r23 b1 b2
r31 a4 
r32 a3 
r33 b2 
;
run;

data Child;
length Child Parent $2.;
input Child Parent;
ChildRepeat = Child;
datalines;
a1 a
a2 a
a3 a
a4 a
b1 b
b2 b
;
run;

* preassumes %lineadj is working correctly, but it is a part of the unit tests... ;
%LineAdj(Line, Child, Child, Adj, Static = LineID);
data Adj;
set Adj(rename = (ChildRepeat = Child ChildRepeat_Adj = Child_Adj) where = (Parent = Parent_Adj));
run;

%Cluster(Adj, Child, Child, Clusters, ShowCount = 0);

data Expect;
length Child ClusterID $2.;
input Child ClusterID;
datalines;
a1 a1
a2 a1
a3 a1
a4 a1
b1 b1
b2 b1
;
run;


%assert_data_equal(ds1 = Expect, ds2 = Clusters);

%test_end();


