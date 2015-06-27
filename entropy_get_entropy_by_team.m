% -*- coding: gbk -*-
% Module            : entropy_get_entropy1.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function entropy = entropy_get_entropy1(train_data, train_match, train_label, l, w)

%% Init
num_match = 380;
num_class = 20;

entropy = zeros(num_class, l * w);

%% Entropy
for i = 1:num_class
    matches_of_class = 1:num_match;
    matches_of_class = matches_of_class(train_label == i);
    I = [];
    for j = 1:size(matches_of_class, 1)
        I = [I; train_match == matches_of_class(j)];
    end
    I = logical(I);
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
