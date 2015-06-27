% -*- coding: gbk -*-
% Module            : entropy_get_entropy.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function entropy = entropy_get_entropy(train_data, train_match, l, w)

%% Init
num_match = 380;

entropy = zeros(num_match, l * w);

%% Entropy
for i = 1:num_match
    I = (train_match == i);
    train_data_team = train_data(I, :);
    for j = 1 : w*l
        I = train_data_team(:, 1) == j;
        count_from_a_region = histc(train_data_team(I, 2:end), 1:w*l);
        if sum(count_from_a_region) > 0
            p_from_a_region = count_from_a_region / sum(count_from_a_region);
            p = p_from_a_region(p_from_a_region > 0);
            entropy(i, j) = - sum(p .* log(p));
        end
    end
end
