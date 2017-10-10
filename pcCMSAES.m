%% Implementation of the pcCMSA-ES algorithm with linear regression analysis.
% 
% The 'population control (pc) CMSA-ES' is based on the standard 
% 'Covariance Matrix Self-Adaptation Evolution Strategy' (CMSA-ES).
% It evolves a population of lambda offspring with individual 
% mutation strengths sigma_l and adapts the step-size
% by recombining the mu most beneficial mutations strengths.
% Further, the covariance matix of the offspring distribution is
% adapted to speed up the evolutionary process.
%
% The pcCMSA-ES collects a squence of noisy fitness values observed
% at the centroid of the parental population after each generation.
% The last L entries of this noisy fitness sequence are then tested 
% for significant noise influences by use of linear regression analysis.
% (see LinearRegNegativeTrend.m)
% The test is repeated after an isolation phase of 'wait' generations.
%
% In case of siginficant noise influence the used population sizes mu
% and lambda are increased by the factor c_mu and the covariance matrix 
% adaptation is stalled in order to avoid gathering noisy information.
% 
% If the noise impact is not evident (enough), the algorithm reduces
% its populations sizes to a predefined minimum (mu_min, etc.).
% The covariance matrix update may be turned on again in these cases.
%
% INPUT: 	input 	- struct array of strategy parameters 
%			  and initial search space location 
%		fname 	- name of the objective function to be optimized
%		dname   - name of the noise detection mechanism 
%			  (linRegression, or MannKendall, respectively)
%
% OUTPUT:	fnoisy	- final observed fitness value
%		y_opt   - optimizer (final candidate solution)
%		dyn 	- struct array of the pcCMSA-ES dynamics	
%

function [fnoisy, y_opt, dyn]=pcCMSAES(fname,dname,input)

    % initialization:
    Parent.sigma   = input.sigma;	% initial step-size
    Parent.y       = input.yInit;	% initial search space location
    n              = length(Parent.y);	% search space dimension
    mu             = input.mu;		% initial parental population size
    C              = eye(n); 		% initial covariance matrix
    mu_min         = input.mu; 		% minimal parental population size
    g              = 0;			% generation counter
    wait           = 0;			% lead time for noise detection
    adjC           = 1;			% covariance update turned (on / off) == (1 / 0)
    
    a 		   = input.coeffs;
    sigma_eps      = input.noise_strength;
    noise_type     = input.noise_model;

    % statistics
    dyn.f          =[];
    dyn.noisyf     =[];
    dyn.sigma      =[];
    dyn.y          =[];
    dyn.fev        =[];		% number of function evaluations
    dyn.lambda     =[];		% offspring population size
    dyn.condC      =[];		% condition number of C
    dyn.fevals     =0;
    
    fevals	   =0;    
    while(1) 
        lambda         = floor(mu/input.theta);	% offspring population size increases 
						% with mu (fixed truncation ratio theta <1)
        clear OffspringPop;			
        for l=1:lambda				% generate new offspring population
          Offspring.sigma   = Parent.sigma*exp(input.taus*randn(1));
          Offspring.s       = chol(C)'*randn(n,1);
          Offspring.z       = Offspring.sigma.*Offspring.s;
          Offspring.y       = Parent.y + Offspring.z;
          Offspring.f       = feval(fname, Offspring.y, a, sigma_eps, noise_type);
          OffspringPop(l)   = Offspring;
        end
        
        ranking = RankPop(OffspringPop,input.ordering); % ordering and selection
	sum_sigma = 0; sum_y = 0; sum_s=0; 		% recombination
        for m = 1:mu; 
          sum_sigma = sum_sigma + OffspringPop(ranking(m)).sigma;
          sum_s     = sum_s + OffspringPop(ranking(m)).s;
          sum_y     = sum_y + OffspringPop(ranking(m)).y;
        end
        Parent.sigma= sum_sigma/mu;
        Parent.s    = sum_s./mu;
        Parent.y    = sum_y./mu;
        Parent.f    = feval(fname, Parent.y, a, sigma_eps, noise_type);       % centroid evaluation 
        f_noisefree = feval(fname, Parent.y, a, sigma_eps, noise_free);       % ideal fitness

        % covariance matrix rank-1 update
        C           =(1-1/input.tauc).^adjC.*C ...
                      +adjC/input.tauc.*(Parent.s*Parent.s');
        % statistics
        g 		    = g+1;
        dyn.f(g)            = f_noisefree; 
        dyn.noisyf(g)       = Parent.f;
        dyn.sigma(g)        = Parent.sigma;
        dyn.y(:, g)         = Parent.y;
        fevals   	    = fevals + lambda +1;
        dyn.fev(g)          = fevals;
        dyn.lambda(g)       = lambda;
        dyn.condC(g)        = cond(C);
        
	% termination condition
        if ( Parent.sigma < input.sigma_stop || g > input.g_stop || fevals >= input.fevals_max )
          break;
        end
	% noise detection and population control
        if ( g > input.L ) 			% necessary length of fitness sequence reached?
             if (wait == 0 )			% lead time expired?
             % having waited for wait generations and considering a 
	     %history of at least L data points check for negative trend 
	     	if isequal(dname,'linRegression')
        		H = LinearRegNegativeTrend( dyn.noisyf(g-input.L:g), input.alpha);
		elseif isequal(dname,'MannKendall')
			H = MannKendallNegativeTrend( dyn.noisyf(g-input.L:g), input.alpha);
		else
		 	disp('Note: The detection machanism was not specified correctly.')
		end
                if ( H )		% negative trend identified 
                    if ( mu > mu_min )	% reduce population size (lower bounded by mu_min)
            		mu   = max( mu_min, floor(mu/input.b_mu) );
			adjC = 1; 	        % covariance matrix update: on
                    end
                else 			% no negative trend identified
                    mu   = mu*input.c_mu; 	% increase the population size
                    adjC = 0;			% covariance matrix update: off
                end
            	% reset wait counter after each test decision
                    wait = input.L;  % (here: wait = L - length of test sequence)
             else
             	wait = wait - 1;     % increment wait counter
             end    
        end
  end
  % output	
  y_opt = Parent.y;
  fnoisy = noisy_f_dyn(g);
end
