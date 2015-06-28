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

l = 8;
w = 10;

%% Preprocess
num_match = 380;
train_data = NBC_data_preprocess(trainData, l, w);
% [(比赛ID - 190) * 2 - 主客队] 作为下半场的 match_id
testData(:, 1) = testData(:, 1) - num_match / 2;
test_data = NBC_data_preprocess(testData, l, w);

%% Run
theta = softmax_train(train_data, trainLabels(:, 3), 0.01, 0.00001, 1000);
[correct_rate_train, est_label_train] = softmax_test(train_data, trainLabels(:, 3), theta);
[correct_rate_test, est_label_test] = softmax_test(test_data, testLabels(:, 3), theta);
disp(['softmax train: ' num2str(correct_rate_train * 100) '%']);
disp(['softmax test: ' num2str(correct_rate_test * 100) '%']);

%% Draw
figure(1);
clf(1);
hold on;
draw_est(trainLabels(:, 3), est_label_train);
title('softmax, train');
hold off;

figure(2);
clf(2);
hold on;
draw_est(testLabels(:, 3), est_label_test);
title('softmax, test');
hold off;
