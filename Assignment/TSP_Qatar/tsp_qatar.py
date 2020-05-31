#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Importing the required packages
import tsplib95
import mlrose
import numpy as np
import matplotlib.pyplot as plt
import time


def solve_ga(problem_fit):
    """ Solving using Genetic Algorithm """
    
    fitness_min = np.inf
    best_params_dict = {}
    
    # Parameter lists
    populuation_list = [100, 500, 1000]
    mutation_prob_list = [0.01,0.1,0.5]

    # Solve
    for p in populuation_list:
        for m in mutation_prob_list:
            # Start timer
            t_start = time.time()
            best_state, best_fitness, fitness_curve = mlrose.genetic_alg(problem=problem_fit,
                                                                         pop_size=p,
                                                                         mutation_prob=m,
                                                                         max_attempts=100,
                                                                         max_iters=5000,
                                                                         random_state = np.random.seed(7),
                                                                         curve=True)
            # End timer
            t_end = time.time()
            # Storing the best result
            if best_fitness < fitness_min:
                fitness_min = best_fitness
                best_params_dict['Fitness'] = best_fitness
                best_params_dict['Solution'] = best_state
                best_params_dict['Population'] = p
                best_params_dict['Mutation'] = m
                best_params_dict['Fitness_curve'] = fitness_curve
                best_params_dict['Time'] = round(t_end - t_start,2)
            
    # Printing the best result
    print("-- Parameters --")
    print("\tPopulation: ",best_params_dict['Population'])
    print("\tMutation probability: ", best_params_dict['Mutation'])
    print("\tMax Attempts at each step: 100")
    print("\tStopping Criterion = Max Iterations of the algorithm: 1000")
    print("Results:")
    print("\tSolution (Order of city traversal by index):  ", best_params_dict['Solution'])
    print("\tFitness: ", round(best_params_dict['Fitness'],2))
    print("Computational Time: ",best_params_dict['Time'], " seconds\n\n")

    # Plotting
    plt.plot(-(best_params_dict['Fitness_curve']))
    plt.title("Convergence curve: TSP-Qatar using Genetic Algorithm")
    plt.xlabel("Iterations")
    plt.ylabel("Fitness")
    plt.savefig("tsp_qatar_ga.png")
    
def solve_sa(problem_fit):
    """ Solving using Simulated Annealing """
    
    min_fitness = np.inf
    best_params_dict = {}
    
    # Parameter list
    initial_temp_list = [10,100,1000]
    min_temp_list = [1,10,100]
    decay_list = [0.001,0.01,0.1]
    
    # Solve
    for t0 in initial_temp_list:
        for t in min_temp_list:
            # Initial temp should be greater than Minimum temp
            if t0 < t:
                continue
            for d in decay_list:
                    for c in range(2):
                        if c == 0:
                            schedule = mlrose.ExpDecay(init_temp=t0, exp_const=d, min_temp=t)
                        else:
                            schedule = mlrose.ArithDecay(init_temp=t0, decay=d, min_temp=t)
                        # Start timer
                        t_start = time.time()
                        best_state, best_fitness, fitness_curve = mlrose.simulated_annealing(problem=problem_fit, 
                                                                                 schedule=schedule,
                                                                                 max_attempts=1000,
                                                                                 max_iters = 10000,
                                                                                 random_state = np.random.seed(7),
                                                                                 curve=True)
                        # End timer
                        t_end = time.time()
                        
                        # Storing the best result
                        if best_fitness < min_fitness:
                            min_fitness = best_fitness
                            best_params_dict['Fitness'] = best_fitness
                            best_params_dict['Solution'] = best_state
                            best_params_dict['Initial_temp'] = t0
                            best_params_dict['Min_temp'] = t
                            best_params_dict['Decay'] = d
                            best_params_dict['Schedule'] = "Exponential" if c == 0 else "Arithmetic" 
                            best_params_dict['Fitness_curve'] = fitness_curve
                            best_params_dict['Time'] = round(t_end - t_start,2)
    
    # Printing the best result
    print("-- Parameters --")
    print("\tCooling Schedule: ", best_params_dict['Schedule'])
    print("\tInitial Temperature: ",best_params_dict['Initial_temp'])
    print("\tMin Temperature: ",best_params_dict['Min_temp'])
    print("\tDecay rate: ",best_params_dict['Decay'])
    print("\tMax Attempts at each step: 100")
    print("\tStopping Criterion = Max Iterations of the algorithm: 10000")
    print("Results:")
    print("\tSolution (Order of city traversal by index):  ", best_params_dict['Solution'])
    print("\tFitness: ", round(best_params_dict['Fitness'],2))
    print("Computational Time: ",best_params_dict['Time'], " seconds\n\n")
    
    # Plotting
    plt.plot(-(best_params_dict['Fitness_curve']))
    plt.title("Convergence curve: TSP-Qatar using Simulated Annealing")
    plt.xlabel("Iterations")
    plt.ylabel("Fitness")
    plt.savefig("tsp_qatar_sa.png")

if __name__=="__main__":
    
    # Reading data
    tsp = tsplib95.load('qa194.tsp')
    tsp_data = tsp.as_name_dict()
    print("##### Data #####\n")
    print(tsp_data)
    print("\n")
    
    # Getting the city coordinates
    cities = [tsp_data['node_coords'][k] for k in tsp_data['node_coords']]
    
    # Initialize fitness function object using coordinates
    fitness_coords = mlrose.TravellingSales(coords = cities)
    
    # Define optimization problem object
    problem_fit = mlrose.TSPOpt(length = len(cities), fitness_fn = fitness_coords, maximize=False)
    
    print("###### Solving using Genetic Algorithm ######\n")
    solve_ga(problem_fit)
    print("###### Solving using Simulated Annealing Algorithm ######\n")
    solve_sa(problem_fit)


    
    