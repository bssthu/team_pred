% -*- coding: gbk -*-
% Module            : run_NBC.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : ���ر�Ҷ˹����
% 

function run_NBC

load('soccerData.mat');

theta = NBC_train(trainData, trainLabels);
correct_rate = NBC_test(testData, testLabels, theta);
disp(correct_rate);
