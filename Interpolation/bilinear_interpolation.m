%双线性插值
function img_new = bilinear_interpolation(img, R)
    [m, n, ~] = size(img);
    img = double(img);
    m_new = round(m * R);
    n_new = round(n * R);
    
    % 创建新图像的行列索引矩阵
    row_ratio = ((1:m_new) - 0.5) / R + 0.5;
    col_ratio = ((1:n_new) - 0.5) / R + 0.5;
    
    % 计算四个邻近点的坐标
    row_floor = floor(row_ratio);
    row_ceil = ceil(row_ratio);
    col_floor = floor(col_ratio);
    col_ceil = ceil(col_ratio);
    
    % 限制索引不超过原图像的大小
    row_floor = max(1, min(row_floor, m));
    row_ceil = max(1, min(row_ceil, m));
    col_floor = max(1, min(col_floor, n));
    col_ceil = max(1, min(col_ceil, n));
    
    % 计算插值权重
    row_alpha = row_ratio - row_floor;
    col_alpha = col_ratio - col_floor;
    
    % 使用矩阵运算进行插值
    img_new = (1 - row_alpha)' * (1 - col_alpha) .* img(row_floor, col_floor, :) ...
             + (1 - row_alpha)' * col_alpha .* img(row_floor, col_ceil, :) ...
             + row_alpha' * (1 - col_alpha) .* img(row_ceil, col_floor, :) ...
             + row_alpha' * col_alpha .* img(row_ceil, col_ceil, :);
    img_new = uint8(img_new);
end