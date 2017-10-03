clear all, clc

input.n               =30;				% search space dimension

input.mu              =3;				% parental population size
input.theta           =1/3;				% fixed population truncation ratio

input.taus            =1/sqrt(2*input.n);		% self-adaptation learning parameter
input.tauc            =1+input.n*(input.n+1)/(2*input.mu);	% Cov. matrix learning rate
input.c_mu            =2;				% population control parameter
input.b_mu	      =1.5;
input.yInit           =ones(input.n,1);			% initial candidate solution
input.sigma           =1;				% initial mutation strength

input.g_stop          =100000;				% termination criteria
input.sigma_stop      =1e-20;
input.fevals_max      =1e+8;

input.fname           = 'EllipsoidModel';		% objective function name
input.exp	      =	0; 				% exp=0 - Sphere model, 
							% exp=1 - Ellipsoid model a_i=i
							% exp=2 - Ellipsoid model a_i=i^2
input.coeffs          = linspace(1,input.n,input.n)'.^input.exp
input.ordering        = 'ascend'; 	% Minimization

% input.noise_model     = 'noise-free';	% Noise model specification
input.noise_model     = 'additive';	
% input.noise_model     = 'f-proportional';	
% input.noise_model     = 'actuator';	

input.noise_strength  = 1;		 % Noise model specific (normalized) noise strength

input.dname	      = 'linRegression'; % noise detection method used by the pcCMSA-ES

if input.exp == 0			 % Problem specific lead time of the pcCMSA-ES
	input.L       = 5*input.n;
else
	input.L       = sum(input.coeffs); 	
end

input.alpha           = 0.05;			% hypothesis test reliabililty

% Single run  of the pcCMSA-ES algorithm
[fnoisy, y_opt, dyn]  = pcCMSAES(input.fname,input.dname,input); 

lr_dyn       = dyn;
lr_dyn.y_opt = y_opt;
 
filename=['pcCMSAlr_N' num2str(input.n) 'ai' num2str(input.exp) 'Lsuma.mat']
save(filename,'lr_dyn','input','-v7')
