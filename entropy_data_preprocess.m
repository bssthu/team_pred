% -*- coding: gbk -*-
% Module            : entropy_data_preprocess.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function [data, label] = entropy_data_preprocess(rawData, T, l, w)
    num_match = 380;
    data = [];
    label = [];
    
    % [实际比赛ID * 2 - 主客队] 作为 match_id_t2
    
    % 遍历每场比赛
    for i = 1 : num_match / 2
        I = rawData(:, 1) == i;
        raw_data = rawData(I, :);
        % 主队
        segments = get_play_segments(raw_data, 1, T, l, w);
        data = [data; segments];
        label = [label; ones(size(segments, 1), 1) * (i * 2 - 1)];
        % 客队
        segments = get_play_segments(raw_data, 0, T, l, w);
        data = [data; segments];
        label = [label; ones(size(segments, 1), 1) * (i * 2)];
    end
end


function segments = get_play_segments(raw_data, home_or_away, T, l, w)
    segments = zeros(5000, T); % M-by-T matrix
    num_segments = 0;
    possession = [];    % 列的含义, 1:时刻, 2:x坐标, 3:y坐标
    % 遍历每个动作
    num_action = size(raw_data, 1);
    for j = 1:num_action
        % 对方动作成功，或射门，或犯规，结束这一轮
        if size(possession, 1) > 0 && ( ...
                ((raw_data(j, 2) ~= home_or_away) && (raw_data(j, 6) == 1)) ...
                || ((raw_data(j, 2) == home_or_away) && (raw_data(j, 4) == 4)) ...
                || ((raw_data(j, 2) == home_or_away) && (raw_data(j, 4) == 9)) ...
                )
            % 处理
            T1 = floor(possession(end, 1) - possession(1, 1));  % length of a possession, in second
            if T1+1 >= T
                N =  size(possession, 1);   % total number of play-segments for a possession
                a = zeros(T1+1, 1);   % the possession string
                t0 = possession(1, 1);
                i_of_p = 1;
                for k = 1:T1+1
                    t = t0 + (k - 1);
                    while possession(i_of_p + 1, 1) < t
                        i_of_p = i_of_p + 1;
                    end
                    t_1 = possession(i_of_p, 1);
                    x_1 = possession(i_of_p, 2);
                    y_1 = possession(i_of_p, 3);
                    t_2 = possession(i_of_p + 1, 1);
                    x_2 = possession(i_of_p + 1, 2);
                    y_2 = possession(i_of_p + 1, 3);
                    x = (x_2 - x_1) / (t_2 - t_1) * (t - t_1) + x_1;
                    y = (y_2 - y_1) / (t_2 - t_1) * (t - t_1) + y_1;
                    a(k) = get_coord(x, y, l, w);
                end
                for k = 1:size(a) - T + 1
                    num_segments = num_segments + 1;
                    segments(num_segments, :) = a(k:k+T-1);
                end
            end
            % clear
            possession = [];
        % 动作
        elseif raw_data(j, 2) == home_or_away
            possession(end + 1, :) = raw_data(j, [5,7,8]);
        end
    end
    segments = segments(1:num_segments, :);
end


function [i_chunk, i_x, i_y] = get_coord(x, y, l, w) % 由X,Y坐标判断点在哪一格
    x_max = 100;
    y_max = 100;
    x_a_chunk = x_max / l;
    y_a_chunk = y_max / w;
    i_x = max(1, ceil(x / x_a_chunk));
    i_y = max(1, ceil(y / y_a_chunk));
    i_chunk = (i_x - 1) * w + i_y;
end
