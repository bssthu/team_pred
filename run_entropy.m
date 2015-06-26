% -*- coding: gbk -*-
% Module            : run_entropy.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 文献[1]的方法
% 

function run_entropy

%% Load
load('soccerData.mat');
trainData;
trainLabels;
testData;
testLabels;

%% Preprocess
num_match_half = 190;
train_data = entropy_data_preprocess(trainData);
% [(比赛ID - 190) * 2 - 主客队] 作为下半场的 match_id
testData(:, 1) = testData(:, 1) - num_match_half;
test_data = entropy_data_preprocess(testData);

%% Run
correct_rate_train = 0;
correct_rate_test = 0;
disp(['entropy train: ' num2str(correct_rate_train * 100) '%']);
disp(['entropy test: ' num2str(correct_rate_test * 100) '%']);
