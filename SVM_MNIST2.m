X = load('data.mat');
Y = load('label.mat');


Y_r = Y.labelTrain;
X_r = reshape(X.imageTrain, 784, size(X.imageTrain, 3))'./255;
Y_t = Y.labelTest;
X_t = reshape(X.imageTest, 784, size(X.imageTest, 3))'./255;
X_r = X_r(Y_r == 7 | Y_r == 1,:);
Y_r = Y_r(Y_r == 7 | Y_r == 1);
Y_r(Y_r == 1) = -1;
Y_r(Y_r == 7) = 1;

X_t = X_t(Y_t == 7 | Y_t == 1,:);
Y_t = Y_t(Y_t == 7 | Y_t == 1);
Y_t(Y_t == 1) = -1;
Y_t(Y_t == 7) = 1;


    K=X_r*X_r'; % Dot-product kernel
    N = size(X_r,1);
  
    cvx_begin quiet
        variable a_m(N);
        minimize ( 0.5.* quad_form(Y_r.*a_m, K)  - ones(N,1)'*(a_m));
        subject to
            a_m >= 0;
            Y_r'*(a_m) == 0;
    cvx_end
    
    a_m(a_m<10^-5)=0;
    X_m = X_r(a_m>0,:);
    Y_m = Y_r(a_m>0);
    a_m = a_m(a_m>0);
    K=X_m*X_m';
    b_m=mean(Y_m-K*(a_m.*Y_m));
    predictions = int8(X_t*X_m'*(a_m.*Y_m) - b_m > 0);
    predictions(predictions == 0) = -1;
     disp('Accuracy')
    disp(sum(int8(Y_t == predictions))/size(Y_t,1))
    
    K = zeros(N,N);
for i=1:N % RBF kernel
    for j = 1:N
            K(i,j) = exp(-1*sum((X_r(i,:)-X_r(j,:)).^2)/(2*(0.01)^2));
    end 
end  
  
    cvx_begin quiet
        variable a_m(N);
        minimize ( 0.5.* quad_form(Y_r.*a_m, K)  - ones(N,1)'*(a_m));
        subject to
            a_m >= 0;
            Y_r'*(a_m) == 0;
    cvx_end
    
    a_m(a_m<10^-5)=0;
    X_m = X_r(a_m>0,:);
    Y_m = Y_r(a_m>0);
    a_m = a_m(a_m>0);
    K=X_m*X_m';
    b_m=mean(Y_m-K*(a_m.*Y_m));
    predictions = int8(X_t*X_m'*(a_m.*Y_m) - b_m > 0);
    predictions(predictions == 0) = -1;
    disp('Accuracy')
    disp(sum(int8(Y_t == predictions))/size(Y_t,1))
    
    