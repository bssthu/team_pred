% -*- coding: utf-8 -*-
% Module            : draw_est.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function draw_est(test_label, est_label)

num_class = 20;

img = zeros(num_class);

for i = 1:num_class
    img(i, :) = histc(est_label(test_label == i), 1:num_class); % ʵ�ʵĵ�i�ӱ��������Щ��
end

axis([0.5, num_class + 0.5, 0.5, num_class + 0.5]);
image(img * 3); % ͼ��ĵ�i��(����������)��ʾʵ�ʵĵ�i��
