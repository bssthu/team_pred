% -*- coding: gbk -*-
% Module            : run_entropy.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 文献[1]的方法
% 

%function run_entropy

%% Load
load('soccerData.mat');
trainData;
trainLabels;
testData;
testLabels;

%% Preprocess
T = 5;
[l, w] = deal(10, 8);
num_match_half = 190;
[train_data, train_match] = entropy_data_preprocess(trainData, T, l, w);
% [(比赛ID - 190) * 2 - 主客队] 作为下半场的 match_id
testData(:, 1) = testData(:, 1) - num_match_half;
[test_data, test_match] = entropy_data_preprocess(testData, T, l, w);

%% Get Entropy
train_entropy = entropy_get_entropy(train_data, train_match, l, w);
test_entropy = entropy_get_entropy(test_data, test_match, l, w);

%% Run
correct_rate_train = 0;
correct_rate_test = 0;
disp(['entropy train: ' num2str(correct_rate_train * 100) '%']);
disp(['entropy test: ' num2str(correct_rate_test * 100) '%']);
