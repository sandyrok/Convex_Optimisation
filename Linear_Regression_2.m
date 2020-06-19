[A,b] = gendata_lasso( );

y = [];
z = [];
lambdas = [];
minx = [];


for l = 5:5:100
 
 % Any of the three functions can put here for optimisation.   
 cvx_begin quiet
  variable x(size(A,2)) 
  minimize (square_pos(norm(A*x-b)) + l*norm(x,1))
 cvx_end
 
 minx = [minx;x.'];
 lambdas = [lambdas,l];
 y = [y,norm(A*x-b)];
 z = [z,l*norm(x)];
end

plot(lambdas,minx)
plot(lambdas,y)
plot(lambdas,z)
