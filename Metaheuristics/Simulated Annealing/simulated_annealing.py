#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import dual_annealing

interval = (-5, 10)

def objective(x):
    """Rosenbrock function: used as a performance test problem for optimization algorithms"""
    result = 0
    for i in range(len(x)-1):
        result+= 100*(x[i+1] - x[i]**2)**2 + (1 - x[i])**2
    return result
    # return x*x

# def bounds(dim):
#     return ((-5,10),)*dim

# def solve(dim):
#     # Starting point
#     x0 = np.random.random_sample((dim,))
#     print(x0)
#     return dual_annealing(objective, bounds= bounds(dim),x0=x0, seed=58)

def update_temperature(fraction, T0):
    """Cooling Schedule"""
    return max(0.01, T0*(1.0 - fraction))

# def update_temperature(step, T0):
#     """Cooling Schedule"""
#     return T0/(1.0+step)

def clip(x):
    """ Keeping x in the interval."""
    a, b = interval
    # return max(min(x, b), a)
    return np.array([max(min(i, b), a) for i in x])

def random_neighbour(x, fraction=1):
    """Move a little bit x, from the left or the right."""
    amplitude = (max(interval) - min(interval)) * fraction / 10
    delta = (-amplitude/2.) + amplitude * np.random.random_sample()
    return clip(x + delta)

def acceptance_probability(cost, new_cost, temperature):
    """Acceptance probability function"""
    if new_cost < cost:
        return 1
    else:
        return np.exp(- (new_cost - cost) / temperature)

def annealing(init_state, cost_function,random_neighbour,T0,maxiter=1000,debug=True):
    # Initial state
    state = init_state
    # Energy => Value of the objective function
    energy = cost_function(state)
    states, energies = [state], [energy]
    T=T0
    for step in range(maxiter):
        fraction = step/float(maxiter)
        T = update_temperature(fraction, T)
        # T = update_temperature(step, T0)
        # T = temperature(fraction)
        new_state = random_neighbour(state, fraction)
        new_energy = cost_function(new_state)
        # if debug: print("Step #{:>2}/{:>2} : T = {:>4.3g}, state = {:>4.3g}, energy = {:>4.3g}, new_state = {:>4.3g}, new_energy = {:>4.3g} ...".format(step, maxiter, T, state, energy, new_state, new_energy))
        if debug and step%5==0: print("Step #{:>2}/{:>2} : T = {:>4.3g}, energy = {:>4.3g}, new_energy = {:>4.3g} ...".format(step, maxiter, T, energy, new_energy))
        # Criteria for acceptance of new state
        if acceptance_probability(energy, new_energy, T) > np.random.random():
            state, energy = new_state, new_energy
            states.append(state)
            energies.append(energy)
    return state, cost_function(state), states, energies

init_state = np.random.random_sample((3,))

state, c, states, energies = annealing(init_state, objective, random_neighbour,T0=100, debug=False)

print("State:", state)
print("Objective:", c)

plt.figure()
# plt.suptitle("Evolution of states and Energies of the simulated annealing")
# plt.subplot(121)
# plt.plot(states, 'r')
# plt.title("States")
# plt.subplot(122)
plt.plot(energies, 'b')
plt.title("Energies")
plt.show()