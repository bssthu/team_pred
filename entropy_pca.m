% -*- coding: gbk -*-
% Module            : entropy_pca.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 文献[1]的方法
% 

function [coeff, score] = entropy_pca(X)

[n, d] = size(X);
Sigma = X' * X / n;
[V, D] = eig(Sigma);
[D, I] = sort(sum(D), 'descend');
V = V(:, I);

coeff = V;
score = X * coeff;
