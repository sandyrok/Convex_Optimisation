n = 10;
a  = -1 + 2 *rand(1,n);
cvx_begin
  variables x(10);
  maximize( sum(entr(x)));
  subject to 
   ones(1,10) * x == 1
cvx_end

scatter(a, x)
