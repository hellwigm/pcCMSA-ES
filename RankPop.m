%% Sorting routine for ranking the offspring within the pcCMSA-ES
%
% INPUT:	pop	- struct array containing (at least) the
%			  observed fitness of the current offspring population
%		key	- string specifying the ordering direction
%			  (either descend - maximization or ascend - minimization)
%
% OUTPUT:	ranking - array containing the ordered offspring indices
%

function ranking = RankPop(pop, key)
  for l=1:length(pop);
    fs(l) = pop(l).f;
  end;
  [sfs, ranking] = sort(fs, key);
end
