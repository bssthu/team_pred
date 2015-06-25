% -*- coding: gbk -*-
% Module            : NBC_train.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function theta = NBC_train(train_data, train_labels)

%% Init
num_class = 20;
num_action = 9;

theta = zeros(num_class, num_action);
action_count = zeros(num_class, num_action);

%% Train
for i = 1:num_class
    I = (train_labels == i);
    action_count(i, :) = sum(train_data(I, :), 1);
    theta(i, :) = action_count(i, :) / sum(action_count(i, :));
end
