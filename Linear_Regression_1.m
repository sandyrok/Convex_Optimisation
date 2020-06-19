%Least-squares fitting
cvx_begin
 variable x(size(A,2)) 
 minimize (square_pos(norm(A*x-b)))
cvx_end

%L2 -regularization
cvx_begin
 variable x(size(A,2)) 
 minimize (square_pos(norm(A*x-b)) + 5 * square_pos(norm(x)))
cvx_end

%L1 -regularization
cvx_begin quiet
  variable x(size(A,2)) 
  minimize (square_pos(norm(A*x-b)) + 5 * norm(x,1))
cvx_end