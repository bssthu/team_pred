% -*- coding: gbk -*-
% Module            : run_NBC.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : ���ر�Ҷ˹����
% 

function run_NBC

load('soccerData.mat');

NBC_train(trainData, trainLabels);
NBC_test(testData, testLabels);
