

n  = 20;
a  = -1 + 2 *rand(1,n);
a2 = a .^ 2;
a3 = 3 * ( a.^ 3 ) - 2 * a;
ap = +( a < 0.5 );
A  = [ a   ; -a  ; a2 ; -a2  ; a3 ; -a3 ; ap ; -ap ];
b  = [ 0.1 ; 0.1 ;0.6 ; -0.5 ; -0.2 ; 0.3 ; 0.4 ; -0.3 ];

%Minimizing a constant function 1 wrt to the prior conditions
% and additional conditions p >=0 and sum(pi) = 1.
%If the distribution is valid then the feasible set is non empty and
% the solution is the constant 1 else the problem is infeasible

cvx_begin quiet
 variables  p(20);
 minimize 1
 subject to 
  ones(1,20) * p == 1
  p >= 0
  A * p <= b
cvx_end
cvx_optval
disp(p)
if all((p >=0) & cvx_optval == 1)
   disp("sum of probabilities:")
   disp(sum(p))
else
    disp('Invalid')
end


