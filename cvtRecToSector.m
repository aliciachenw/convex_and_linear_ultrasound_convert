function sec_img = cvtRecToSector(rect_img, params)
    left_top = params.left_top;
    right_top = params.right_top;
    left_bottom = params.left_bottom;
    right_bottom = params.right_bottom;

    rect_width = params.rect_width;
    rect_height = params.rect_height;
    sec_width = params.sec_width;
    sec_height = params.sec_height;

    sec_img = zeros(sec_height, sec_width);

    x_center = (left_top(1) + right_top(1)) / 2;
    k = (left_bottom(2) - left_top(2)) / (left_bottom(1) - left_top(1));
    y_center = k * (x_center - left_top(1)) + left_top(2);

    sec_theta = atan2(right_bottom(1) - x_center, right_bottom(2) - y_center);
    sec_rad = [sqrt((left_top(1) - x_center) ^ 2 + (left_top(2) - y_center) ^ 2) ...
        sqrt((left_bottom(1) - x_center) ^ 2 + (left_bottom(2) - y_center) ^ 2)];

    rect_width_to_theta = rect_width / (2 * sec_theta);
    rect_height_to_rad = rect_height / (sec_rad(2) - sec_rad(1));
    
    lowest_y = y_center + sec_rad(2);
    for sx = left_bottom(1):right_bottom(1)
        for sy = left_top(2):round(lowest_y)
            t = atan2(sx - x_center, sy - y_center);
            r = sqrt((sx - x_center) ^ 2 + (sy - y_center) ^ 2);
            rx = rect_width_to_theta * (t + sec_theta);
            ry = rect_height_to_rad * (r - sec_rad(1));
            rx = round(rx);
            ry = round(ry);

            if 1 <= rx && rx <= rect_width && 1 <= ry && ry <= rect_height
                sec_img(sy, sx) = rect_img(ry, rx);
            end
        end
    end

    sec_img = cast(sec_img, 'uint8');
    sec_img = sec_img(:,:,[1 1 1]); 
end