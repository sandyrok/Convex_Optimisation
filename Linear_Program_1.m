

%Calling Data Generator
n = 200;
d = 10;
[A,x1,b] = SandeepReddyRokkam_Q1_2();

% L1 Norm minimization as Linear Program
% Solves problem for the generated data and prints the error in the
% solution and the error in the minimiser

cvx_begin quiet
  variables x(d) t(n);
  minimize( ones(1,n) * t  );
  subject to 
   A * x - t <= b
   -A * x - t <= -b
   t >= 0
cvx_end
cvx_optval
disp("L1 Minimization:")
disp("error in solution")
disp( cvx_optval)
disp("error in minimizer")
disp(norm(x - x1))

%L(inf) Norm minimization as Linear Program
% Solves problem for the generated data and prints the error in the
% solution and the error in the minimiser

cvx_begin quiet
  variables x(d) t;
  minimize( t );
  subject to 
   A * x - t*ones(n,1) <= b
   -A*x - t*ones(n,1) <= -b
cvx_end
disp("L(inf) minimization:")
disp("error in solution")
disp( cvx_optval)
disp("error in minimizer")
disp(norm(x - x1))





