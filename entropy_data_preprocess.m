% -*- coding: gbk -*-
% Module            : entropy_data_preprocess.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function data = entropy_data_preprocess(rawData, T, l, w)
    num_match = 380;
    
    % [实际比赛ID * 2 - 主客队] 作为 match_id_t2
    match_id_t2 = rawData(:, 1) * 2 - rawData(:, 2);
    
    % 遍历每场比赛
    for i = 1 : num_match / 2
        I = rawData(:, 1) == i;
        raw_data = rawData(I, :);
        % 主队
        get_play_segments(raw_data, 1, T, l, w);
        % 客队
        get_play_segments(raw_data, 1, T, l, w);
    end
    
end


function get_play_segments(raw_data, home_or_away, T, l, w)
    posession = [];
    % 遍历每个动作
    for j = 1:size(raw_data, 1)
        % 对方动作成功，或射门，或犯规，结束这一轮
        if ((raw_data(j, 2) ~= home_or_away) && (raw_data(j, 6) == 1)) ...
                || ((raw_data(j, 2) == home_or_away) && (raw_data(j, 4) == 4 || raw_data(j, 4) == 9))
            % 处理
            num_act =  size(posession, 1);
            % clear
            posession = [];
        % 动作
        elseif (raw_data(j, 2) == home_or_away)
            posession(end + 1, :) = raw_data(j, :);
        end
    end
end


function [i_chunk, i_x, i_y] = get_coord(x, y, l, w) % 由X,Y坐标判断点在哪一格
    x_max = 100;
    y_max = 100;
    x_a_chunk = x_max / l;
    y_a_chunk = y_max / w;
    i_x = max(1, ceil(x / x_a_chunk));
    i_y = max(1, ceil(y / y_a_chunk));
    i_chunk = i_x * w + i_y;
end
