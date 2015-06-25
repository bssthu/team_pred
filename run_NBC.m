% -*- coding: gbk -*-
% Module            : run_NBC.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 朴素贝叶斯方法
% 

function run_NBC

%% Load
load('soccerData.mat');
trainData;
trainLabels;
testData;
testLabels;

%% Preprocess
num_match_half = 190;
[train_data, train_label] = NBC_data_preprocess(trainData, trainLabels);
% [(比赛ID - 190) * 2 - 主客队] 作为下半场的 match_id
testData(:, 1) = testData(:, 1) - num_match_half;
[test_data, ~] = NBC_data_preprocess(testData, testLabels);

%% Run
theta = NBC_train(train_data, train_label);
correct_rate_train = NBC_test(train_data, trainLabels(:, 3), theta);
correct_rate_test = NBC_test(test_data, testLabels(:, 3), theta);
disp(['NBC train: ' num2str(correct_rate_train * 100) '%']);
disp(['NBC test: ' num2str(correct_rate_test * 100) '%']);
