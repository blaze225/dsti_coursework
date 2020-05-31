# Continuous optimization: Shifted Ackley's Function

## Definition of the Function

![ackley_definition](images/ackley_definition.png)

## Solution

I used the Particle Swarm Optimzation algorithm as in general it works well for continuous optimization problems and can search very large spaces of candidate solutions.

### Dimension 50

1. Chosen Algorithm: Particle Swarm Optimzation from pygmo

2. Parameters Tested
* Population (Particle Swarm size):  [50, 100, 200]
* Omega (inertia factor):  [0.2, 0.4, 0.6, 0.8]
* eta1 (social component):  [0.5, 1, 2, 3]
* eta2 (cognitive component):  [0.5, 1, 2, 3]
* Maximum allowed particle velocity:  [0.2, 0.4, 0.6, 0.8]

3. Best Parameters  
* Search Space = [-32, 32]  
* Bias = -140  
* Population (Particle Swarm size):  100
* Omega (inertia factor):  0.2
* eta1 (social component):  1
* eta2 (cognitive component):  1
* Maximum allowed particle velocity:  0.4
	
4. Results
* Solution: 
>  	[ 12.95052633 -10.79586083   4.22764779   2.22764774   5.19189644
      12.78036677   5.43778411   8.0688676   -1.06539927  -4.30099842
      -5.34037307  13.91376084   1.19927201   8.25156081  -8.32945597
     -14.74029179 -13.0837847   16.00151143   0.69964902   2.815603
      -6.56577744 -12.47240685  12.52809526   0.52660973  -2.32708881
      -5.1337654    9.4756861  -10.36454801  -1.69167188  -6.04577297
     -12.00229097  14.7293289   15.55725443  16.71530858  17.09928891
       4.80152417  -5.24749485 -10.61718915 -10.78972446  -4.39075849
       6.4304108   -5.64445523   1.06360828  10.37183994   6.90835268
      10.15076278  -3.47532516   3.34458981  -0.19517366  18.64547949]
* Fitness: -119.51

5. Stopping Criterion = Number of generations: 1000
6. Computational Time:  30.98  seconds
7. Convergence Curve

![ackley_50_pso](images/ackley_50_pso.png)

### Dimension 500

1. Chosen Algorithm: Particle Swarm Optimzation from pygmo

2. Parameters Tested
* Population (Particle Swarm size):  [50, 100, 200]
* Omega (inertia factor):  [0.2, 0.4, 0.6, 0.8]
* eta1 (social component):  [0.5, 1, 2, 3]
* eta2 (cognitive component):  [0.5, 1, 2, 3]
* Maximum allowed particle velocity:  [0.2, 0.4, 0.6, 0.8]

3. Best Parameters  
* Search Space = [-32, 32]  
* Bias = -140 
* Population (Particle Swarm size):  100
* Omega (inertia factor):  0.2
* eta1 (social component):  0.5
* eta2 (cognitive component):  0.5
* Maximum allowed particle velocity:  0.2
  
4. Results
* Solution: 
>   [-32.30589605  76.98588332 -20.64464619  24.32971679  15.64413599
     7.34543254  -3.41773987 -25.87697292  86.78815641 -19.82233573
    77.78926865 -68.01292077 -15.6124968  -39.64030618 -57.30750059
     6.76278454  29.15742336 -68.23556265  19.8998812  -46.25433927 
    -27.98369752 -60.88681179  35.6862432   59.75457283 -19.16759508
    -0.12571492   6.85747297 -69.63109476  60.37280354 -23.87988731
   -75.36498856   4.51538476  52.77226306  58.69726095   3.83487608
   -74.90971532  64.36029806  12.13798656  30.02893308  33.7483257
    27.82472768 -46.27358159  34.86923739   8.88976878 -10.73438498
   -29.84506193  -7.69072179 -22.6839387   25.02580945 -81.92358408]
* Fitness: 390.0

5. Stopping Criterion = Number of generations: 1000
6. Computational Time:  35.82  seconds
7. Convergence Curve

![ackley_500_pso](images/ackley_500_pso.png)