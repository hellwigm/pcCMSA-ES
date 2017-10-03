# The pcCMSA-ES using linear regression analysis

1. ### REFERENCE:  
   
   Hellwig, Michael; Beyer, Hans-Georg, "Evolution under Strong Noise: A Self-Adaptive Evolution Strategy Can Reach the Lower Performance Bound - the pcCMSA-ES", J. Handl et al. (Ed.): Parallel Problems Solving from Nature - PPSN XIV, pp. 26-37, Edinburgh Napier University, Edinburgh, Scotland, UK, Springer, 2016.

2. ### NOTICE:  

   The pcCMSA-ES code is made available for reproduction of reported results and testing. The use of the code is permitted subject to the condition of properly acknowledging this source (https://github.com/hellwigm/pcCMSA-ES/) as well as citing the relevant papers.

3. ### The pcCMSA-ES:  

   The pcCMSA-ES is based on the well-known Covariance Matrix Self-Adaptation Evolution Strategy (CMSA-ES). Incorporating a rather simple population control mechanism togehter with an appropriate noise detection method, the population control Covariance Matrix Self-Adaptation Evolution Strategy (pcCMSA-ES) is able to successfully deal with noisy optimization problems. The noise detection mechanism is based on applying linear regression analysis to a sequence of observed noisy objective function values. The slope of the estimated regression line governs the population control.Constructing a test statistic allows for the design of a hypothesis test that provides the decline requirement.  
   
   negative slope w.r.t significance level \alpha      --> reduce population size  
   non-negative slope w.r.t significance level \alpha  --> increase population size
   
   Notice, that representing a parametric approach, the use of linear regression analysis is only appropriate for additive normally distributed fitness noise disturbances. In order to tackle different forms of noise, the pcCMSA-ES may be equipped with a non-parametric noise detection method (e.g. maiking use of the Mann-Kendall test). In such cases the noise detection procedure __LinearRegNegativetrend.m__ may simply be repalced with __MannKendall.m__. 
   
4. ### File description:  

  * __EllipsoidModel.m__      - Test function defining the fitness environment referred to as the Ellipsoid model 
  * __pcCMSAESlr.m__          - Main component of the pcCMSA-ES algorithm relying on either Linear Regression Analysis or the Mann Kendall Test for noise detection
  * __LinearRegNegativeTrend.m__ - Trend estimation making use of the linear regression line's slope and a corresponding hypothesis test
  * __MannKendallNegativeTrend.m__ - Alternative non-parametric trend estimation: The Mann-Kendall test for identification of significant downward montonic trend.
  * __RankPop.m__                 - Ranking Procedure
  * __sample_Experiment.m__      - Executable for sample pcCMSA-ES runs
