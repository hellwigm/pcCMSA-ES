%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%% Noise detection by linear regression analysis of the sequence y.
%
% The procedure calculates the linear regression line y = a*x + b and
% determines variance of its slope a.
% Assuming that the data errors are normally distributed, a confidence 
% interval CI is calculated for the estimated slope a.
% In case that the upper bound of CI is less than 0, 
% a negative trend is assumed. That is, significant noise influence
% on the time series y is NOT evident.
% 
% INPUT:	f 	- sequence of measured noisy fitness values
			  (time series)
%		alpha 	- significance level of the hypothesis test
%
% OUTPUT:	H = 1	- there is a negative trend with 
%			  error probability at most alpha
%		H = 0	- otherwise 
%

function H = LinearRegNegativeTrend(f, alpha)
  n = length(f); 				% length of fitness sequence
  f_mean = mean(f);				% sample mean value of the observations
  x = (1:n);					%
  x_mean = mean(x);				%
  sxf = sum( (x-x_mean) .* (f-f_mean) );	% 
  sxq = sum( (x-x_mean) .^2 );			% 
  a = sxf/sxq;					% estimated slope of the regression line
  b = f_mean - a*x_mean;			% intercept of the estimated regression line
  mse = sum( (f - a*x - b) .^2 );		% sum of squared residuals
  sigma_a = sqrt( mse/((n-2)*sxq) );		% standard error of the estimator in the t-statistic
  ci_up = a + tinv( 1-alpha, n-2 ) * sigma_a;   % upper bound of confidence interval CI
  H = ci_up < 0;				% final test 
end

