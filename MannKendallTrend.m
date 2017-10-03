%% Implementation of the MANN-KENDALL Test for negative trend
%
% The original non-parametric Mann-Kendall test for identification of significant
% downward montonic trend.
%
% null hypothesis --  H0: no monotonic trend within the time series
% alternative 	  --  Ha: monotonic downward trend at error rate 'alpha'
% To test the null hypothesis H0 versus Ha, H0 is rejected and Ha is accepted if
% the Mann-Kendall test statistic is smaller than (or equal to) -pz,
% where pz is the 100(1−α)th percentile of the standard normal distribution.
% The result of the test is returned in 'H' at the alpha significance level 'alpha'.
%
% INPUT: 	x  		-- time series 
%		alpha 		-- significance level of the test 
%
%		Note: The significance level of a test is a threshold of probability a agreed
%		to before the test is conducted. A typical value of alpha is 0.05. 
%		
% OUTPUT: 	H, test result 	-- '1' reject the null hypthesis (-> downward trend present),
%				   '0' insufficient evidence to reject the null hypothesis
%		p_val 		-- The p-value is the probability of obtaining a test statistic 
% 				   value of the same or of greater magnitude than the
%				   realizations computed from the sample.
%		Note: 	If the p-value is less than the chosen significance level, 
%			that suggests that the observed data is sufficiently inconsistent with 
% 			the null hypothesis that the null hypothesis may be rejected. 
%			However, that does not prove that the tested hypothesis is true.
%
% References:
%	Mann, H. B., Nonparametric tests against trend, Econometrica, Vol. 13, p. 245--259, 1945.
%	Kendall, M. G., Rank Correlation Methods, Griffin, London, 1975.
%	Gilbert, R.O., Statistical Methods for Environmental Pollution Monitoring, Wiley, NY, 1987.

function [H]=MannKendallNegativeTrend(x,alpha)
    % number of time series entries
    n=length(x);
    if n <= 10
	disp('Warning: Time series may be to short for a reliable test decision.')
	disp('See also Gilbert (1987, Sec.16.4.1).')
    end
    % compute the number of positive differences 
    % minus the number of negative differences 's'
    S=0; 
    for i=1:n-1
        for j= i+1:n 
            S= S + sign(x(j)-x(i)); 		
        end
    end
    VarS=(n*(n-1)*(2*n+5))/18;			% Compute the varaince of S
    StdS=sqrt(VarS); 				% Standard deviation of S
    % Compute the Mann-Kendall test statistic Z as follows:	
    % Notice: ties are not considered here
    if S >= 0
        Z=((S-1)/StdS)*(S~=0);
    else
        Z=(S+1)/StdS;
    end
    % Looking for downward trends:  
    pz=norminv(1-alpha,0,1); 		% 100(1−α)th percentile of the standard normal distribution
    H= (Z <= -pz); 			% compute the test result
end 
