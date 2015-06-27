% -*- coding: gbk -*-
% Module            : entropy_get_avgentropy.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function avg_entropy = entropy_get_avgentropy(train_entropy, train_label, test_entropy, test_label)

num_class = 20;

entropy = [train_entropy; test_entropy];
labels = [train_label; test_label];

avg_entropy = zeros(num_class, 1);

for i = 1:num_class
    I = labels == i;
    avg_entropy(i) = sum(sum(entropy(I, :))) / sum(I);
end
