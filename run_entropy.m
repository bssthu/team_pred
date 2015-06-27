% -*- coding: gbk -*-
% Module            : run_entropy.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 文献[1]的方法
% 

function run_entropy

%% Init
load('soccerData.mat');
trainData;
trainLabels;
testData;
testLabels;

T = 5;
[l, w] = deal(8, 10);
num_match = 380;

% [(比赛ID - 190) * 2 - 主客队] 作为下半场的 match_id
testData(:, 1) = testData(:, 1) - num_match / 2;

%% Preprocess
[train_data, train_match] = entropy_data_preprocess(trainData, T, l, w);
[test_data, test_match] = entropy_data_preprocess(testData, T, l, w);
% save('./temp_data/entropy_preprocess', 'train_data', 'train_match', 'test_data', 'test_match');

%% Get Entropy
% load('./temp_data/entropy_preprocess.mat');
train_entropy = entropy_get_entropy(train_data, train_match, l, w);
test_entropy = entropy_get_entropy(test_data, test_match, l, w);

%% Test
[~, train_test_entropy_score] = entropy_pca([train_entropy; test_entropy]);
train_entropy_score = train_test_entropy_score(1:num_match, 1:20);
test_entropy_score = train_test_entropy_score(num_match+1:end, 1:20);

[correct_rate_test, est_label] = entropy_test_nearest(...
        train_entropy_score, trainLabels(:, 3), test_entropy_score, testLabels(:, 3));
disp(['entropy test: ' num2str(correct_rate_test * 100) '%']);

%% Draw
figure(1);
clf(1);
hold on;
draw_est(testLabels(:, 3), est_label);
title('文献[1]的方法');
hold off;

% train_entropy_by_team = entropy_get_entropy_by_team(...
%         train_data, train_match, trainLabels(:, 3), l, w);
% for i = 1:20
%     team = i;
%     figure(2);
%     clf(2);
%     hold on;
%     img = reshape(train_entropy_by_team(team, :), w, l);
%     image(img * 25);
%     axis([0.5, l + 0.5, 0.5, w + 0.5]);
%     %colorbar;
%     title(['Entropy of team ' num2str(team)]);
%     hold off;
%     print('-f2', ['temp_data/entropy_team_' num2str(team) '.eps'], '-r300', '-depsc');
% end
