
param N;  # number of cities

set CITIES := 1..N;  # set of cities

param C{i in CITIES, j in CITIES};  # distance from city i to city j

var x{i in CITIES, j in CITIES: i != j} binary;  # binary decision variables for path existence
var u{i in CITIES} >= 0;  # artificial variables

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

