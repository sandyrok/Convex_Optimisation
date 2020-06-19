
[X,Y] = svm_gendata (100,100);


X = X.';
Y = Y.';
N = size(X,1);

for sigma = [0.01,0.1,0.5,10,100]

K = zeros(N,N);
for i=1:N % RBF kernel
    for j = 1:N
            K(i,j) = exp(-1*sum((X(i,:)-X(j,:)).^2)/(2*(sigma)^2));
    end 
end  
    cvx_begin quiet
        variable a_m(N);
        minimize ( 0.5.* quad_form(Y.*a_m, K)  - ones(N,1)'*(a_m));
        subject to
            a_m >= 0;
            Y'*(a_m) == 0;
    cvx_end
 
    a_m(a_m<10^-5)=0;
    X_m = X(a_m>0,:);
    Y_m = Y(a_m>0);
    a_m = a_m(a_m>0);
    K=X_m*X_m';
    b_m=mean(Y_m-K*(a_m.*Y_m));
    predictions = int8(X*X_m'*(a_m.*Y_m) - b_m > 0);
    predictions(predictions == 0) = -1;
     disp('Training error')
    disp(sum(int8(Y ~= predictions))/size(Y,1))
    

end