% -*- coding: gbk -*-
% Module            : run_entropy.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 文献[1]的方法
% 

%function run_entropy

%% Init
load('soccerData.mat');
trainData;
trainLabels;
testData;
testLabels;

T = 5;
[l, w] = deal(8, 10);
num_match_half = 190;

%% Preprocess
[train_data, train_match] = entropy_data_preprocess(trainData, T, l, w);
% [(比赛ID - 190) * 2 - 主客队] 作为下半场的 match_id
testData(:, 1) = testData(:, 1) - num_match_half;
[test_data, test_match] = entropy_data_preprocess(testData, T, l, w);
save('./temp_data/entropy_preprocess', 'train_data', 'train_match', 'test_data', 'test_match');

%% Get Entropy
load('./temp_data/entropy_preprocess.mat');
train_entropy = entropy_get_entropy(train_data, train_match, l, w);
test_entropy = entropy_get_entropy(test_data, test_match, l, w);

%% Run
%correct_rate_train = 0;
[correct_rate_test, est_label] = entropy_test_nearest(train_entropy, trainLabels(:, 3), test_entropy, testLabels(:, 3));
%disp(['entropy train: ' num2str(correct_rate_train * 100) '%']);
disp(['entropy test: ' num2str(correct_rate_test * 100) '%']);

%% Draw
figure(1);
clf(1);
hold on;
draw_est(testLabels(:, 3), est_label);
title('文献[1]的方法');
hold off;

train_entropy_by_team = entropy_get_entropy_by_team(...
        train_data, train_match, trainLabels(:, 3), l, w);
figure(2);
clf(2);
hold on;
img = reshape(train_entropy_by_team(1, :), l, w);
image(img * 25);
colorbar;
hold off;
