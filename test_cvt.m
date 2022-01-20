close all


test_path = 'data/c17.jpg';
sec_img = imread(test_path);
sec_img = im2gray(sec_img);

%% set parameters
% set the vertices in image coordinate
params.left_top = [255 33];
params.left_bottom = [93 349];
params.right_top = [422 34];
params.right_bottom = getRightBottom(params);
% set the desire linear image size
params.rect_height = 500;
params.rect_width = 476;

params.sec_height = size(sec_img, 1);
params.sec_width = size(sec_img, 2);


%% convert curve probe image to linear probe image
rect_img = cvtSectorToRect(sec_img, params);

%% conver linear probe image to curve probe image
sec_img_2 = cvtRecToSector(rect_img, params);

%% visualization
figure;
subplot(1, 3, 1)
imshow(sec_img)
subplot(1, 3, 2)
imshow(rect_img)
subplot(1, 3, 3)
imshow(sec_img_2)
