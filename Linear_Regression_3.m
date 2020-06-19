sigma = [];
y = [];
for s = 0.1:0.1:2
 [A,b] = gendata_lasso(200, 50, s,1);
 
 % Any of the three functions can put here for optimisation.
 cvx_begin quiet
  variable x(size(A,2)) 
  minimize (square_pos(norm(A*x-b)))
 cvx_end
 sigma = [sigma,s];
 s
 t = A*x - b;
 q = sqrt(t.'* t/size(t,1));
 y = [y,q];
end
plot(sigma,y)