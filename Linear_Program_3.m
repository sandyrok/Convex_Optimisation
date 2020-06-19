%Calling Data Generator
n = 200;
d = 10;
[A,x1,b] = SandeepReddyRokkam_Q1_2();


% L1 Norm minimization
% Solves problem for the generated data and prints the error in the
% solution and the error in the minimiser
cvx_begin quiet
  variable x(d);
  minimize( norm(A*x -b, 1) );
cvx_end
disp("L1 Minimization:")
disp("error in solution")
disp( cvx_optval)
disp("error in minimizer")
disp(norm(x - x1))


%L(inf) Norm minimization
% Solves problem for the generated data and prints the error in the
% solution and the error in the minimiser
cvx_begin quiet
  variable x(d);
  minimize( norm(A*x -b, Inf) );
cvx_end
disp("L(inf) minimization:")
disp("error in solution")
disp( cvx_optval)
disp("error in minimizer")
disp(norm(x - x1))