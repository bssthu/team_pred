% -*- coding: gbk -*-
% Module            : entropy_data_preprocess.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function data = entropy_data_preprocess(rawData, T, l, w)
    num_match = 380;
    
    % [ʵ�ʱ���ID * 2 - ���Ͷ�] ��Ϊ match_id_t2
    match_id_t2 = rawData(:, 1) * 2 - rawData(:, 2);
    
    % ����ÿ������
    for i = 1 : num_match / 2
        I = rawData(:, 1) == i;
        raw_data = rawData(I, :);
        % ����
        get_play_segments(raw_data, 1, T, l, w);
        % �Ͷ�
        get_play_segments(raw_data, 1, T, l, w);
    end
    
end


function get_play_segments(raw_data, home_or_away, T, l, w)
    posession = [];
    % ����ÿ������
    for j = 1:size(raw_data, 1)
        % �Է������ɹ��������ţ��򷸹棬������һ��
        if ((raw_data(j, 2) ~= home_or_away) && (raw_data(j, 6) == 1)) ...
                || ((raw_data(j, 2) == home_or_away) && (raw_data(j, 4) == 4 || raw_data(j, 4) == 9))
            % ����
            num_act =  size(posession, 1);
            % clear
            posession = [];
        % ����
        elseif (raw_data(j, 2) == home_or_away)
            posession(end + 1, :) = raw_data(j, :);
        end
    end
end


function [i_chunk, i_x, i_y] = get_coord(x, y, l, w) % ��X,Y�����жϵ�����һ��
    x_max = 100;
    y_max = 100;
    x_a_chunk = x_max / l;
    y_a_chunk = y_max / w;
    i_x = max(1, ceil(x / x_a_chunk));
    i_y = max(1, ceil(y / y_a_chunk));
    i_chunk = i_x * w + i_y;
end
