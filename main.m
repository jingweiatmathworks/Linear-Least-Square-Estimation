%% An example for applying Linear Least Square Estimation
% y = a* t^2 + b*t + c
% Goal: estimate x =[a;b;c]

clc;
clear;
close all;

%% Initialization
rng(2020);
a = 2; b= 3; c = 1; % Truth
aBar = 1.7; bBar = 3.3; cBar = 0.8; % A priori state
Xbar = [aBar; bBar; cBar];
P0 = diag([0.5^2 0.5^2 0.5 ^2]); % A priori covariance

%% Generate 10 measurements
y = @(t)   a*t.^2+ b.*t + c; % measure function

std = 0.5; % 1-D ouput
R = std^2;


n = 1000;
t = (1:1:n)';
Y = y(t) + std * randn(n,1);

%% Calculate estimate

H = [t.^2 t ones(n,1)];
XTrue =[a;b;c]

XCrude = inv(H'*H)*H'*Y
XBetter = (H'/R*H +eye(3)/P0)\(H'/R*Y+eye(3)/P0*Xbar) % with a priori state

error = norm(XBetter - XTrue)