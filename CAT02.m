clear all
clc
% This Matlab Script is primarily for CAT02 Chromatic adaptation
% experimentint the three methods for finding the brightest object

% Method 1, matrix gives you the RGB of the pixel with highest Achromatic
% channel
imagenames = {"1-1.png",'1-2.png','1-3.png','5.png','Lab2_5-1_2.jpg','Lab2_5-1_3.jpg','Lab2_5-1_4.jpg'};
M = [0.38971, 0.69989, -0.07868; -0.22981, 1.18340, 0.04641; 0 0 1];
M_cat02 = [0.7328 0.4296 -0.1624; -0.7036 1.6975 0.0061; 0.0030 0.0136 0.9834];
% Destination illumination is D65 
XYZ_destination_ill = [95.04,100,108.89];
LMS_destination_ill = (M*(XYZ_destination_ill)')';

for i=1:length(imagenames)
    image = imread(imagenames{i});
    [m,n,k] = size(image);
    im_reshaped = double(reshape(image, m*n,k));
    % sRGB to XYZ
    XYZ_source_image = srgb2xyz(im_reshaped);
    XYZ_source_image = XYZ_source_image';
    % Source illumination
    RGB_source_ill = methodone(image);
    XYZ_source_ill = srgb2xyz(double(RGB_source_ill));
    LMS_source_ill = (M*(XYZ_source_ill)')';

    % CAT02 Chromatic Adaptation
    [channel, cols] = size(XYZ_source_image);
    LMS = M_cat02*XYZ_source_image;
    LMS_c = zeros(channel, cols);
    LMS_c(1,:) = (((XYZ_source_ill(2)*LMS_destination_ill(1))./(XYZ_destination_ill(2)*LMS_source_ill(1)) ))*LMS(1,:);
    LMS_c(2,:) = (((XYZ_source_ill(2)*LMS_destination_ill(2))./(XYZ_destination_ill(2)*LMS_source_ill(2)) ))*LMS(2,:);
    LMS_c(3,:) = (((XYZ_source_ill(2)*LMS_destination_ill(3))./(XYZ_destination_ill(2)*LMS_source_ill(3)) ))*LMS(3,:);
    M_inv = inv(M_cat02);
    XYZ_destination_image = (M_inv*LMS_c);
    RGB_destination = xyz2srgb(XYZ_destination_image');
    FinalImage = uint8(reshape(RGB_destination, [m, n, k]));

    figure;
    imshow(FinalImage)
    title("Final Image with CAT02")
end
%%
% Method two - user select a white point from the image manually
clear all
clc
imagenames = {"1-1.png",'1-2.png','1-3.png','5.png','Lab2_5-1_2.jpg','Lab2_5-1_3.jpg','Lab2_5-1_4.jpg'};
M = [0.38971, 0.69989, -0.07868; -0.22981, 1.18340, 0.04641; 0 0 1];
M_cat02 = [0.7328 0.4296 -0.1624; -0.7036 1.6975 0.0061; 0.0030 0.0136 0.9834];
% Destination illumination is D65 
XYZ_destination_ill = [95.04,100,108.89];
LMS_destination_ill = (M*(XYZ_destination_ill)')';

for i=1:length(imagenames)
    image = imread(imagenames{i});
    [m,n,k] = size(image);
    im_reshaped = double(reshape(image, m*n,k));
    % sRGB to XYZ
    XYZ_source_image = srgb2xyz(im_reshaped);
    XYZ_source_image = XYZ_source_image';
    % Source illumination
    RGB_source_ill = methodtwo(image);
    XYZ_source_ill = srgb2xyz(double(RGB_source_ill));
    LMS_source_ill = (M*(XYZ_source_ill)')';

    % CAT02 Chromatic Adaptation
    [channel, cols] = size(XYZ_source_image);
    LMS = M_cat02*XYZ_source_image;
    LMS_c = zeros(channel, cols);
    LMS_c(1,:) = (((XYZ_source_ill(2)*LMS_destination_ill(1))./(XYZ_destination_ill(2)*LMS_source_ill(1)) ))*LMS(1,:);
    LMS_c(2,:) = (((XYZ_source_ill(2)*LMS_destination_ill(2))./(XYZ_destination_ill(2)*LMS_source_ill(2)) ))*LMS(2,:);
    LMS_c(3,:) = (((XYZ_source_ill(2)*LMS_destination_ill(3))./(XYZ_destination_ill(2)*LMS_source_ill(3)) ))*LMS(3,:);
    M_inv = inv(M_cat02);
    XYZ_destination_image = (M_inv*LMS_c);
    RGB_destination = xyz2srgb(XYZ_destination_image');
    FinalImage = uint8(reshape(RGB_destination, [m, n, k]));

    figure;
    imshow(FinalImage)
    title("Final Image with CAT02")
end
%%
%Method 3 - GreyWorld
clear all
clc
imagenames = {"1-1.png",'1-2.png','1-3.png','5.png','Lab2_5-1_2.jpg','Lab2_5-1_3.jpg','Lab2_5-1_4.jpg'};
M = [0.38971, 0.69989, -0.07868; -0.22981, 1.18340, 0.04641; 0 0 1];
M_cat02 = [0.7328 0.4296 -0.1624; -0.7036 1.6975 0.0061; 0.0030 0.0136 0.9834];
% Destination illumination is D65 
XYZ_destination_ill = [95.04,100,108.89];
LMS_destination_ill = (M*(XYZ_destination_ill)')';

for i=1:length(imagenames)
    image = imread(imagenames{i});
    [m,n,k] = size(image);
    im_reshaped = double(reshape(image, m*n,k));
    % sRGB to XYZ
    XYZ_source_image = srgb2xyz(im_reshaped);
    XYZ_source_image = XYZ_source_image';
    % Source illumination
    XYZ_source_ill = methodthree(image);
    LMS_source_ill = (M*(XYZ_source_ill)')';

    % CAT02 Chromatic Adaptation
    [channel, cols] = size(XYZ_source_image);
    LMS = M_cat02*XYZ_source_image;
    LMS_c = zeros(channel, cols);
    LMS_c(1,:) = (((XYZ_source_ill(2)*LMS_destination_ill(1))./(XYZ_destination_ill(2)*LMS_source_ill(1)) ))*LMS(1,:);
    LMS_c(2,:) = (((XYZ_source_ill(2)*LMS_destination_ill(2))./(XYZ_destination_ill(2)*LMS_source_ill(2)) ))*LMS(2,:);
    LMS_c(3,:) = (((XYZ_source_ill(2)*LMS_destination_ill(3))./(XYZ_destination_ill(2)*LMS_source_ill(3)) ))*LMS(3,:);
    M_inv = inv(M_cat02);
    XYZ_destination_image = (M_inv*LMS_c);
    RGB_destination = xyz2srgb(XYZ_destination_image');
    FinalImage = uint8(reshape(RGB_destination, [m, n, k]));

    figure;
    imshow(FinalImage)
    title("Final Image with CAT02")
end
