% -*- coding: gbk -*-
% Module            : run_NBC.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 朴素贝叶斯方法
% 

function run_NBC

load('soccerData.mat');

NBC_train(trainData, trainLabels);
NBC_test(testData, testLabels);
