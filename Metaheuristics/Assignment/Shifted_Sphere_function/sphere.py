#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from pygmo import *
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import time

class shifted_sphere_function:
    def __init__(self, dim, bias, bounds):
        self.dim = dim
        self.bias = bias
        self.bounds = bounds        

    def fitness(self, x):
        global best_fitness
        F = np.sum(np.square(np.array(x) - np.array(shifts[:self.dim]))) + self.bias
        best_fitness.append(F)
        return [F]

    def get_bounds(self):
        return ([self.bounds[0]] * self.dim, [self.bounds[1]] * self.dim)

    def get_name(self):
        return "Shifted Sphere Function"

    def get_extra_info(self):
        return "\tDimensions: " + str(self.dim)

def solve_pso(dim, bias, bounds):
    """ Solving using Particle Swarm Optimization"""    
    
    global best_fitness
    best_fitness_curr = np.inf
    best_params_dict = {}
    
    # Paramter list
    omega_list = [0.2, 0.4, 0.6, 0.8]
    eta1_list = [0.5, 1, 2, 3]
    eta2_list = [0.5, 1, 2, 3]
    max_vel_list = [0.2, 0.4, 0.6, 0.8]
    population_size_list = [50, 100, 200]
    
    # Defining the problem in pygmo
    prob = problem(shifted_sphere_function(dim, bias, bounds))

    
    # Solve
    for omega in omega_list:
        for eta1 in eta1_list:
            for eta2 in eta2_list:
                for max_vel in max_vel_list:
                    for pop_size in population_size_list:
                        best_fitness = []
                        
                        # Defining the population and algorithm objects in pygmo
                        pop = population(prob, pop_size)
                        algo = algorithm(pso(gen = 3000, omega = omega, eta1 = eta1, eta2 = eta2, 
                                             max_vel = max_vel, seed = 7))
                        #algo.set_verbosity(50)
                            
                        # Start timer
                        t_start = time.time()
                        # Solve
                        result = algo.evolve(pop)
                        # End timer
                        t_end = time.time()
                        
                        # Storing the best result
                        if result.champion_f < best_fitness_curr:
                            best_fitness_curr = result.champion_f
                            best_params_dict['Fitness'] = result.champion_f
                            best_params_dict['Solution'] = result.champion_x
                            best_params_dict['omega'] = omega
                            best_params_dict['eta1'] = eta1
                            best_params_dict['eta2'] = eta2
                            best_params_dict['max_vel'] = max_vel
                            best_params_dict['pop_size'] = pop_size
                            best_params_dict['Fitness_curve'] = best_fitness
                            best_params_dict['Time'] = round(t_end - t_start, 2)
    
    # Print the best result
    print("-- Best Parameters --")
    print("\tPopulation (Particle Swarm size): ", best_params_dict['pop_size'])
    print("\tOmega (inertia factor): ", best_params_dict['omega'])
    print("\teta1 (social component): ",best_params_dict['eta1'])
    print("\teta2 (cognitive component): ",best_params_dict['eta2'])
    print("\tMaximum allowed particle velocity: ",best_params_dict['max_vel'])
    print("-- Results --")
    print("\tSolution:  ", best_params_dict['Solution'])
    print("\tFitness: ", round(best_params_dict['Fitness'][0],2))
    print("Stopping Criterion = Number of generations: 3000")
    print("Computational Time: ",best_params_dict['Time'], " seconds\n\n")

    # Get min for each swarm of particles in an iteration/generation
    fitness_curve = np.array([np.min(np.array(best_params_dict['Fitness_curve'][i:i+best_params_dict['pop_size']])) for i in range(0,len(best_params_dict['Fitness_curve']), best_params_dict['pop_size'])])
    
    # Plotting
    plt.plot(fitness_curve)
    plt.title("Convergence curve: Shifted Sphere function using PSO")
    plt.xlabel("Iterations")
    plt.ylabel("Fitness")
    if dim == 50:
        plt.savefig("sphere_50_pso.png")
    else:
        plt.savefig("sphere_500_pso.png")
        # Saving solution to csv
        df = pd.DataFrame({'solution':best_params_dict['Solution']}) 
        df.to_csv("solution_500.csv")                       

if __name__=="__main__":
    
    # Read shift data
    shifts = []
    with open('shift_values.txt','r') as f:
        for line in f:
            shifts.append(float(line[:-1]))
    
    # Function parameters
    dim = (50,500)
    bias = -450
    bounds = (-100, 100)

    # Solve
    best_fitness = []
    print("##### PSO for Dimension:50 #####\n")
    solve_pso(dim[0], bias, bounds)
    print("##### PSO for Dimension:500 #####\n")
    solve_pso(dim[1], bias, bounds)

    