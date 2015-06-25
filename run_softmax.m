% -*- coding: gbk -*-
% Module            : run_softmax.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : Softmax 回归
% 

function run_softmax

%% Load
load('soccerData.mat');
trainData;
trainLabels;
testData;
testLabels;

%% Preprocess
num_match_half = 190;
train_data = NBC_data_preprocess(trainData);
% [(比赛ID - 190) * 2 - 主客队] 作为下半场的 match_id
testData(:, 1) = testData(:, 1) - num_match_half;
test_data = NBC_data_preprocess(testData);

%% Run
theta = softmax_train(train_data, trainLabels(:, 3), 0.00008, 0.000001, 15000);
correct_rate_train = 1 - softmax_error(train_data, trainLabels(:, 3), theta);
correct_rate_test = 1 - softmax_error(test_data, testLabels(:, 3), theta);
disp(['softmax train: ' num2str(correct_rate_train * 100) '%']);
disp(['softmax test: ' num2str(correct_rate_test * 100) '%']);
