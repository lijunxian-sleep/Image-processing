%双三次插值
function img_new = bicubic_interpolation(img, R)
    [m, n, ~] = size(img);
    img = double(img);
    m_new = round(m * R);
    n_new = round(n * R);
    
    % 创建新图像的行列索引矩阵
    row_ratio = ((1:m_new) - 0.5) / R + 0.5;
    col_ratio = ((1:n_new) - 0.5) / R + 0.5;
    
    % 计算16个邻近点的坐标
    row_floor = floor(row_ratio);
    col_floor = floor(col_ratio);
    
    % 限制索引不超过原图像的大小
    row_floor = max(1, min(row_floor, m));
    col_floor = max(1, min(col_floor, n));
    
    % 计算插值权重
    row_alpha = row_ratio - row_floor;
    col_alpha = col_ratio - col_floor;
    
    % 使用矩阵运算进行插值
    img_new = zeros(m_new, n_new, 3);
    for i = -1:2
        for j = -1:2
            img_new = img_new + kernel(row_alpha - i)' * kernel(col_alpha - j) .* img(min(max(1, row_floor + i), m), min(max(1, col_floor + j), n), :);
        end
    end
    
    img_new = uint8(img_new);
end


function res = kernel(x)
    % 双三次插值核函数
    ax = abs(x);
    res = (ax <= 1) .* (1.5 * ax.^3 - 2.5 * ax.^2 + 1) + (1 < ax & ax <= 2) .* (-0.5 * ax.^3 + 2.5 * ax.^2 - 4 * ax + 2);
end

% 
% function res = kernel(x)
%     % 双三次插值核函数
%     a = -0.5; 
%     ax = abs(x);
%     res = (ax <= 1) .* ((a+2) * ax.^3 - (a+3) * ax.^2 + 1) + (1 < ax & ax <= 2) .* (a * ax.^3 - 5 * a * ax.^2 + 8 *a * ax - 4 * a);
% end