% -*- coding: gbk -*-
% Module            : entropy_pca.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : ����[1]�ķ���
% 

function [coeff, score] = entropy_pca(X)

[n, d] = size(X);
Sigma = X' * X / n;
[V, D] = eig(Sigma);
[D, I] = sort(sum(D), 'descend');
V = V(:, I);

coeff = V;
score = X * coeff;
