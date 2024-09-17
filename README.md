# Particle-Swarm-Optimization-using-Matlab

- - - -
## Introduction

Swarm Intelligence is a branch of Artificial Intelligence where we observe nature and try to learn how different biological phenomena can be imitated in a computer system to optimize the scheduling algorithms. In swarm intelligence, we focus on the collective behavior of simple organisms such as ants,fishes or birds and their interaction with the environment.

Proposed in 1995 by J. Kennedy an R.Eberhart, the article “Particle Swarm Optimization” became very popular due to  this continue optimization process allowing variations to multi targets and more. Consisting in the constant search of best solution, the method moves the particles with a certain velocity calculated in every iteration. Each particle’s movement has the influence of his own the best known position and also the best known position in the space-search, known as the global best position. The final result expected is that the particle swarm converge to the best solution. It’s important to mention that PSO doesn’t use Gradient Descent, so it can be used to non linear problems once it doesn’t require that the problem have to be differentiable.

In this repository we will be trying to implement the basic PSO algorithm as given below using `Matlab` from scratch. The repository includes two sub-folders namely 'pso-basic' and 'pso-func'.
Any beginner is recommended to start at 'pso-basic'.
To understand the inspiration behind the algorithm and the mathematics governing the model have a look at the original [paper.](https://www.cs.tufts.edu/comp/150GA/homeworks/hw3/_reading6%201995%20particle%20swarming.pdf)
- - - -

1. Adaptive Optimization: One of the key advantages of using the PSO algorithm for ANC is its adaptive optimization capabilities. PSO can dynamically adjust ANC system parameters in real-time to deal with varying noise environments. This adaptability is crucial for maintaining effective noise cancellation in situations where the noise pattern changes frequently, such as in automotive or aviation applications.

2. Efficiency and Convergence: The PSO algorithm is known for its efficiency and quick convergence to an optimal solution. In the context of ANC, this means that the system can quickly adapt to new noise conditions and find the optimal parameters for noise cancellation without requiring extensive computational resources. This efficiency makes PSO an excellent choice for embedded systems or applications where processing power is limited.

3. Robustness and Flexibility: PSO's robustness to the initial choice of parameters and its flexibility in handling non-linear optimization problems make it particularly suited for ANC applications. The algorithm can optimize a wide range of ANC system parameters, from filter coefficients to microphone and speaker placements, ensuring that the system can effectively cancel out complex and dynamically changing noise patterns.

## Algorithm 

```
Initialize the controlling parameters (N,c1,c2,Wmin,Wmax,Vmax,MaxIter)
Initialize the population of N particles
do
	for each particle
		calculate the objective of the particle
		update PBEST if required
		update GBEST if required
	end for
	update the inertia weight
	for each particle
		update velocity (v)
		update position (x)
	end for
while the end condition is not satisfied
return GBEST as the best estimation of global optimum
```

- - - -
