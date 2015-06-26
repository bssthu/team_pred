% -*- coding: gbk -*-
% Module            : entropy_get_entropy.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function entropy = entropy_get_entropy(train_data, train_match, l, w)

%% Init
num_class = 20;

entropy = zeros(num_class, l * w);

%% Entropy
for i = 1:num_class
    I = (train_match == i);
    train_data_team = train_data(I, :);
    for i = 1 : w*l
        I = train_data_team(:, 1) == i;
        count_from_a_region = histc(train_data_team(I, 2:end), 1:w*l);
    end
end
