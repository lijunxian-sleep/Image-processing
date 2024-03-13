%最近邻插值
function img_new = nearest_neighbor(img, R)
    [m, n, ~] = size(img);
    m_new = round(m * R);
    n_new = round(n * R);
    
    % 创建新图像的行列索引矩阵
    row_index = round(((1:m_new) - 0.5) / R + 0.5);
    col_index = round(((1:n_new) - 0.5) / R + 0.5);
    
    % 限制索引不超过原图像的大小
    row_index = min(row_index, m);
    col_index = min(col_index, n);
    
    % 使用矩阵运算进行插值
    img_new = img(row_index, col_index, :);
    
end