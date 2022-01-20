% cvt sector image to a rectangle image

function rect_img = cvtSectorToRect(sec_img, params)
    left_top = params.left_top;
    right_top = params.right_top;
    left_bottom = params.left_bottom;
    right_bottom = params.right_bottom;

    rect_width = params.rect_width;
    rect_height = params.rect_height;
    sec_width = params.sec_width;
    sec_height = params.sec_height;

    rect_img = zeros(rect_height, rect_width);

    x_center = (left_top(1) + right_top(1)) / 2;
    k = (left_bottom(2) - left_top(2)) / (left_bottom(1) - left_top(1));
    y_center = k * (x_center - left_top(1)) + left_top(2);

    sec_theta = atan2(right_bottom(1) - x_center, right_bottom(2) - y_center);
    sec_rad = [sqrt((left_top(1) - x_center) ^ 2 + (left_top(2) - y_center) ^ 2) ...
        sqrt((left_bottom(1) - x_center) ^ 2 + (left_bottom(2) - y_center) ^ 2)];

    rect_width_to_theta = rect_width / (2 * sec_theta);
    rect_height_to_rad = rect_height / (sec_rad(2) - sec_rad(1));

    for ry = 1:rect_height
        for rx = 1:rect_width
            t = rx / rect_width_to_theta - sec_theta;
            r = ry / rect_height_to_rad + sec_rad(1);
            sx = x_center + r * sin(t);
            sy = y_center + r * cos(t);

            sx = round(sx);
            sy = round(sy);
            
            if 1 <= sx && sx <= sec_width && 1 <= sy && sy <= sec_height
                rect_img(ry, rx) = sec_img(sy, sx);
            end
        end
    end
    rect_img = cast(rect_img, 'uint8');
    rect_img = rect_img(:,:,[1 1 1]); 
end