% -*- coding: utf-8 -*-
% Module            : draw_est.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function draw_est(test_label, est_label)

num_class = 20;

img = zeros(num_class);

for i = 1:num_class
    img(i, :) = histc(est_label(test_label == i), 1:num_class); % 实际的第i队被分类成哪些队
end

axis([0.5, num_class + 0.5, 0.5, num_class + 0.5]);
image(img * 3); % 图像的第i行(从下往上数)表示实际的第i队
