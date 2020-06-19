n  = 20;
rng("default")
a  = -1 + 2 *rand(1,n);
a2 = a .^ 2;
a3 = 3 * ( a.^ 3 ) - 2 * a;
ap = +( a < 0.5 );
A  = [ a   ; -a  ; a2 ; -a2  ; a3 ; -a3 ; ap ; -ap ];
b  = [ 0.1 ; 0.1 ;0.6 ; -0.5 ; -0.2 ; 0.3 ; 0.4 ; -0.3 ];



cvx_begin quiet
    variables p(20)
    maximize( sum(entr(p)) )
    sum(p) == 1;
    A * p <= b;
cvx_end

if all(A*p <=b)
    disp('Prior is met')
else
    disp('Prior is not met')
end
scatter(a,p)

