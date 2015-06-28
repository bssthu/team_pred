% -*- coding: gbk -*-
% Module            : softmax_train.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function theta = softmax_train(data, label, alpha, alpha_end, maxIter)
    k = max(label);
    [m, p] = size(data);
    data = [data, ones(m, 1)];
    p = p + 1;
    
    theta = ones(k, p) / k / p;
    
    [J, gJ] = getJ(data, label, theta);
    disp(['J = ' num2str(J)]);
    for i = 1:maxIter
        if i == 400 % speed up
            alpha = alpha * 2;
        end
        theta_new = theta - alpha * gJ;
        [J_new, gJ] = getJ(data, label, theta_new);
        while J_new > J
            alpha = alpha / 2;
            if alpha < alpha_end
                return;
            end
            disp(['new alpha = ' num2str(alpha)]);
            theta_new = theta - alpha * gJ;
            [J_new, gJ] = getJ(data, label, theta_new);
        end
        J = J_new;
        theta = theta_new;
        if mod(i, 100) == 0
            disp(['J = ' num2str(J)]);
        end
    end
end


function [J, gJ] = getJ(x, y, theta)
    k = max(y);
    [m, ~] = size(x);
    dfractor = sum(exp(x * theta'), 2);
    J = - sum(sum(theta(y, :) .* x, 2) - log(dfractor)) / m;
    
    tmp = zeros(k, m);
    for j = 1:k
        tmp(j, :) = (y == j) - exp(theta(j, :) * x')' ./ dfractor;
    end
    gJ = - tmp * x / m;
end
