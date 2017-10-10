%% Test function: The Ellipsoid model
% 
% Implementation of the fitness environment defined by the Ellipsoid model.
% In the noise-free case, this objective function represents 
% the general case of a positive definite quadratic form (PDQF).
%
% The ellipsoidal coefficients 'coeffs > 0' determine the condition
% number of the objective function.  
% 
% The implentation considers three different types of noise
% disturbances: additive noise, fitness-propotional noise or
% actuator noise subject to the components of the search space 
% parameter x.
%
% In the noisy cases, fitness or actuator noise is modeled by
% perturbations follwing a Gaussian distribution with mean 'zero'
% and standard deviation 'noise_strength'.
%
% INPUT:	x		- search space parameter vector (column)
%		coeffs  	- column vector of positive coefficients
%				  (usually proportional to the i-th component of x)
%		noise_strength  - standard deviation of the modeled noise
%		noise_type      - string: 'noise-free','additive','f-propotional', or 'actuator'
% 
% OUTPUT: 	fit 		- the observed noisy fitness value 
%

function [fit]=EllipsoidModel(x,coeffs,noise_strength,noise_type)
    if isempty(noise_type) || isequal(noise_type,'noise_free')
	% noise-free ellipsoid model
	if isempty(noise_type)
		disp('Warning: Specify appropriate noise model.')
		disp('noise-free scenario assumed')
	end
	xq      =x.^2;
	fit     =coeffs'*xq;
    elseif isequal(noise_type,'additive')
	% additve Gaussian fitness noise
	xq      =x.^2;
    	fit     =coeffs'*xq + noise_strength*randn(1);
    elseif isequal(noise_type,'f-proportional')
	% fitness proportional noise
	% Note: The parameter 'noise_strength' specifies the 
	%	fixed NORMALIZED noise strength in this scenario.
	suma    =sum(coeffs);
    	sumay   =sum(coeffs.^2.*xq);
        fit     =coeffs'*xq + noise_strength*2*sumay/suma*randn(1);
    else isequal(noise_type,'actuator')
	% Gaussian actuator noise
	n       =length(x);
	xq      =(x+ noise_strength.*randn(n,1)).^2;
    	fit     =coeffs'*xq;
    end
end
