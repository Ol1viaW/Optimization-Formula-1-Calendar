param N;  # number of cities

set CITIES := 1..N;  # set of cities

param C{i in CITIES, j in CITIES};  # distance from city i to city j

var x{i in CITIES, j in CITIES: i != j} binary;  # binary decision variables for path existence
var u{i in CITIES} >= 0;  # artificial variables
var y binary;
var z binary;
var t binary;
var s1 binary;
var s2 binary;

# Objective Function: minimize total distance traveled
minimize Total_Distance:
    sum{i in CITIES, j in CITIES: i != j} C[i,j] * x[i,j];

# Constraints
subject to One_Outgoing_Edge {i in CITIES}:
    sum{j in CITIES: j != i} x[i,j] = 1;

subject to One_Incoming_Edge {j in CITIES}:
    sum{i in CITIES: i != j} x[i,j] = 1;

subject to Subtour_Elimination {i in CITIES, j in CITIES: 2 <= i && 2<= j && i != j && i<= N && j<= N}:
    u[i] - u[j] + N * x[i,j] <= N - 1;


#7-1
subject to Constraint7_1:
#+12 so u constraints go from 1 to 22
	u[9] >=9;


#7-2
subject to Constraint7_2a:
	0 <= u[16] - 7*y + 22*y <= 22;
subject to Constraint7_2b:
	u[16] >= 18*z;
subject to Constraint7_2c:
	y + z = 1;


#7-3
subject to Constraint7_3a:
	x[6,17] = 0;
subject to Constraint7_3b:
	x[17,6] = 0;
subject to Constraint7_3c:
	x[6,20] = 0;
subject to Constraint7_3d:
	x[20,6] = 0;
subject to Constraint7_3e:
	x[17,20] = 0;
subject to Constraint7_3f:
	x[20,17] = 0;


#7-4
subject to Constraint7_4a:
	u[1] = 1;
subject to Constraint7_4b:
	u[22] = 22;

#7-5
subject to Constraint7_5:
	x[4,5] + x[5,4] = 1;

#7-6
subject to Constraint7_6a:
	u[19] >= 12 * t;
subject to Constraint7_6b:
	t >= 1 - u[8] / 11;
subject to Constraint7_6c:
	u[19] <= 22; #idk if we sill need this

#7-7
subject to Constraint7_7a: #s1, s2
	u[2] <= 22 - 11*s1;
subject to Constraint7_7b: #s1, s2
	u[21] <= 22 - 11*s2;
subject to Constraint7_7c: #s1, s2
	s1 + s2 >= 1;
