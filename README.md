# Stochasti cOptimization Alghoritms

This program compares the performance of two optimization algorithms, pure random search (PRS) and multi-start (MS), on two benchmark functions, Ackley and Rosenbrock. 

The PRS algorithm generates random points within a given range and evaluates the function at those points. 

The MS algorithm starts the optimization process from multiple initial points and returns the minimum value found. 

The program runs each algorithm 50 times and produces histograms and box plots to compare their results in terms of mean, standard deviation, and p-values from a t-test.
