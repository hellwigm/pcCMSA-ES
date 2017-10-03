# The pcCMSA-ES using linear regression analysis

1. ### REFERENCE: 
Hellwig, Michael; Beyer, Hans-Georg, "Evolution under Strong Noise: A Self-Adaptive Evolution Strategy Can Reach the Lower Performance Bound - the pcCMSA-ES", J. Handl et al. (Ed.): Parallel Problems Solving from Nature - PPSN XIV, pp. 26-37, Edinburgh Napier University, Edinburgh, Scotland, UK, Springer, 2016.

2. ### NOTICE:
The pcCMSA-ES code is made available for reproduction of reported results and testing. The use of the code is permitted subject to the condition of properly acknowledging this source (https://github.com/hellwigm/pcCMSA-ES/) as well as citing the relevant papers.

3. ### The pcCMSA-ES:
The pcCMSA-ES is based on the well-known Covariance Matrix Self-Adaptation Evolution Strategy (CMSA-ES). Incorporating a rather simple population control mechanism togehter with an appropriate noise detection method, the population control Covariance Matrix Self-Adaptation Evolution Strategy (pcCMSA-ES) is able to successfully deal with noisy optimization problems. The noise detection mechanism is based on applying linear regression analysis to a sequence of observed noisy objective function values. The slope of the estimated regression line governs the population control.Constructing a test statistic allows for the design of a hypothesis test that provides the decline requirement. 
 . negative slope w.r.t significance level \alpha      --> reduce population size 
 . non-negative slope w.r.t significance level \alpha  --> increase population size

4. BRANCH CONTENT:
   ... EllipsoidModel.m          -- Test function defining the fitness environment referred to as the Ellipsoid model
   ... pcCMSAESlr.m              -- Main compponent of the pcCMSA-ES algorithm using Linear Regression Analysis for noise detection
   ... LinearRegNegativeTrend.m  -- Detection mechanism making use of the linear regression line's estimated slope and a corresponding hypothesis test
   ... RankPop.m                 -- Ranking Procedure
   ... sample_Experiment.m       -- Executable for sample pCCMSA-ES runs
