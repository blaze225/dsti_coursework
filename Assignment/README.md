# Metaheuristics Assignment

The objective of this assignment is to solve different problems using metaheuristics. You will have 2 discrete optimization problems and 6 continuous problems to solve.

For each function you are expected to report:
- The chosen algorithm and a justification of this choice
- The parameters of the algorithm
- The final results, both solution and fitness
- The number of function evaluations
- The stopping criterion
- The computational time
- The convergence curve (fitness as a function of time)

## Discrete Optimization

* TSP problem with 38 cities (Djibouti)
* TSP problem with 194 cities (Qatar)

Data (in TSPLIB format) can be found on the [link](http://www.math.uwaterloo.ca/tsp/world/countries.html)

## Continuous Optimization

Optimizing the first 6 functions (F1-F6) available in the CEC2008_TechnicalReport.pdf

Provide results for both dimension D = 50 and D = 500

* F1: Shifted Sphere Function
* F2 : Shifted Schwefel’s Problem 2.21
* F3 : Shifted Rosenbrock’s Function
* F4 : Shifted Rastrigin’s Function
* F5 : Shifted Griewank’s Function
* F6 : Shifted Ackley’s Function

The code of the functions as well as the shifts are available in cec08.rar (in C)

## Optimization Libraries used

* mlrose
* pygmo