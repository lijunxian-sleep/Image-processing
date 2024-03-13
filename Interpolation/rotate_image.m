%图像旋转
function img_rotated = rotate_image(img, angle)
    [m, n, ~] = size(img);
    
    %计算旋转矩阵
    theta = deg2rad(angle);
    R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    
    %计算新图像的大小
    corners = R * [1, m, m, 1; 1, 1, n, n];
    m_new = round(max(corners(1, :)) - min(corners(1, :)));
    n_new = round(max(corners(2, :)) - min(corners(2, :)));
    
    %创建新图像
    img_rotated = zeros(m_new, n_new, size(img, 3));
    
    %计算旋转中心
    center_old = [(m+1)/2; (n+1)/2];
    center_new = [(m_new+1)/2; (n_new+1)/2];
    
    %对每个像素进行旋转
    for i = 1 : m_new
        for j = 1 : n_new
            pos_new = [i; j] - center_new;
            pos_old = round(R' * pos_new + center_old);
            if pos_old(1) >= 1 && pos_old(1) <= m && pos_old(2) >= 1 && pos_old(2) <= n
                img_rotated(i, j, :) = img(pos_old(1), pos_old(2), :);
            end
        end
    end
    
    %转换为原图像的数据类型
    img_rotated = cast(img_rotated, class(img));
end

