% Get the right bottom of the sector given other three sector points

function right_bottom = getRightBottom(params)
    left_top = params.left_top;
    right_top = params.right_top;
    left_bottom = params.left_bottom;
    right_bottom = [left_top(1) + right_top(1) - left_bottom(1) left_bottom(2)];
end