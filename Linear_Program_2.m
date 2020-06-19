function [A,x,b] = SandeepReddyRokkam_Q1_2()
%% function to generate test data
rng('default')
x = randn(10,1);
A = randn(200,10);
b = A*x;

end