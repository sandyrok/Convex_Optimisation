X = load('data.mat');
Y = load('label.mat');


Y_r = Y.labelTrain;
X_r = reshape(X.imageTrain, 784, size(X.imageTrain, 3))'./255;
Y_t = Y.labelTest;
X_t = reshape(X.imageTest, 784, size(X.imageTest, 3))'./255;
X_r = X_r(Y_r == 8 | Y_r == 6,:);
Y_r = Y_r(Y_r == 8 | Y_r == 6);
Y_r(Y_r == 6) = -1;
Y_r(Y_r == 8) = 1;

X_t = X_t(Y_t == 8 | Y_t == 6,:);
Y_t = Y_t(Y_t == 8 | Y_t == 6);
Y_t(Y_t == 6) = -1;
Y_t(Y_t == 8) = 1;
m = size(X_r,1);
n = 784;

 cvx_begin quiet
        variables w(n) b;
        minimize norm(w);
        subject to
          ones(m,1) - Y_r .* ((X_r*w) + b * ones(m,1)) <= 0
 cvx_end

 
 predictions = int8((X_t*w + b * ones(size(Y_t,1),1)) > 0);

 predictions(predictions == 0) = -1;
 disp('Accuracy in Percentage')
 disp(sum(Y_t == predictions)/size(X_t,1) *100)
 

 
 
 
 

