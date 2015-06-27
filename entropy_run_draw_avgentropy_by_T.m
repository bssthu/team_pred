% -*- coding: utf-8 -*-
% Module            : entropy_run_draw_avgentropy_by_T.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

%function entropy_run_draw_avgentropy_by_T()

%% Init
load('soccerData.mat');
trainData;
trainLabels;
testData;
testLabels;

[l, w] = deal(8, 10);
num_class = 20;
num_match = 380;

T_range = 2:30;
mean_entropy = zeros(30, num_class);
% [(比赛ID - 190) * 2 - 主客队] 作为下半场的 match_id
testData(:, 1) = testData(:, 1) - num_match / 2;

%% Run
for i = 1:length(T_range)
    T = T_range(i);
    disp(['T=' num2str(T)]);
    %% Preprocess
    [train_data, train_match] = entropy_data_preprocess(trainData, T, l, w);
    [test_data, test_match] = entropy_data_preprocess(testData, T, l, w);
    
    %% Get Entropy
    train_entropy = entropy_get_entropy(train_data, train_match, l, w);
    test_entropy = entropy_get_entropy(test_data, test_match, l, w);
    
    %% Avg Entropy
    mean_entropy(i, :) = entropy_get_avgentropy(train_entropy, trainLabels(:, 3), test_entropy, testLabels(:, 3));
end

%% Draw
figure(1);
clf(1);
hold on;
h = zeros(num_class, 1);
for i = 1:num_class
    h(i) = plot(T_range, mean_entropy(1:length(T_range), i));
end
xlim([0, 40]);
xlabel('Length of Play-Segment Window, T (seconds)');
ylabel('Mean Entropy');
hl = legend(h);
hold off;
