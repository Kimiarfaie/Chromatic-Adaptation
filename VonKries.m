clear all
clc
% This Matlab Script is primarily for von Kries Chromatic adaptation
% experimentint the three methods for finding the brightest object

% Method 1, matrix gives you the RGB of the pixel with highest Achromatic
% channel
imagenames = {"1-1.png",'1-2.png','1-3.png','5.png','Lab2_5-1_2.jpg','Lab2_5-1_3.jpg','Lab2_5-1_4.jpg'};
for i=1:length(imagenames)
    image = imread(imagenames{i});
    [m,n,k] = size(image);
    im_reshaped = double(reshape(image, m*n,k));
    % sRGB to XYZ
    XYZ_source_image = srgb2xyz(im_reshaped);
    
    % Source illumination
    RGB_source_ill = methodone(image);
    XYZ_source_ill = srgb2xyz(double(RGB_source_ill));
    M = [0.38971, 0.69989, -0.07868; -0.22981, 1.18340, 0.04641; 0 0 1];
    LMS_source_ill = (M*(XYZ_source_ill)')';
    
    % Destination illumination is D65 
    XYZ_destination_ill = [95.04,100,108.89];
    LMS_destination_ill = (M*(XYZ_destination_ill)')';
    
    % Von Kries Chromatic Adaptation
    % Conversion from XYZ of source to XYZ of destination
    M_conversion = inv(M)*...
        [LMS_destination_ill(1)./LMS_source_ill(1) 0 0;...
        0 LMS_destination_ill(2)./LMS_source_ill(2) 0;...
        0 0 LMS_destination_ill(3)./LMS_source_ill(3)]*M;
    
    XYZ_destination_image = (M_conversion*XYZ_source_image')';
    RGB_destination = xyz2srgb(XYZ_destination_image);
    FinalImage = uint8(reshape(RGB_destination, [m, n, k]));

    figure;
    imshow(FinalImage)
    title("Final Image with von Kries")
    % Prepare the filename
    filename = sprintf('Method1_VK_im%d.png', i);
    % Save the final processed image
    imwrite(FinalImage, filename);
end
%%
% Method two - user select a white point from the image manually
clear all
clc
imagenames = {"1-1.png",'1-2.png','1-3.png','5.png','Lab2_5-1_2.jpg','Lab2_5-1_3.jpg','Lab2_5-1_4.jpg'};
M = [0.38971, 0.69989, -0.07868; -0.22981, 1.18340, 0.04641; 0 0 1];
% Destination illumination is D65 
XYZ_destination_ill = [95.04,100,108.89];
LMS_destination_ill = (M*(XYZ_destination_ill)')';

for i=1:length(imagenames)
    image = imread(imagenames{i});
    [m,n,k] = size(image);
    im_reshaped = double(reshape(image, m*n,k));
    % sRGB to XYZ
    XYZ_source_image = srgb2xyz(im_reshaped);
    
    % Source illumination
    RGB_source_ill = methodtwo(image);
    XYZ_source_ill = srgb2xyz(double(RGB_source_ill));
    LMS_source_ill = (M*(XYZ_source_ill)')';
    
    % Von Kries Chromatic Adaptation
    % Conversion from XYZ of source to XYZ of destination
    M_conversion = inv(M)*...
        [LMS_destination_ill(1)./LMS_source_ill(1) 0 0;...
        0 LMS_destination_ill(2)./LMS_source_ill(2) 0;...
        0 0 LMS_destination_ill(3)./LMS_source_ill(3)]*M;
    
    XYZ_destination_image = (M_conversion*XYZ_source_image')';
    RGB_destination = xyz2srgb(XYZ_destination_image);
    FinalImage = uint8(reshape(RGB_destination, [m, n, k]));

    figure;
    imshow(FinalImage)
    title("Final Image with von Kries")
    % % Prepare the filename
    % filename = sprintf('Method2_VK_im%d.png', i);
    % % Save the final processed image
    % imwrite(FinalImage, filename);
end
%%
%Method 3 - GreyWorld
clear all
close all
clc
M = [0.38971, 0.69989, -0.07868; -0.22981, 1.18340, 0.04641; 0 0 1];
% Destination illumination is D65 
XYZ_destination_ill = [95.04,100,108.89];
LMS_destination_ill = (M*(XYZ_destination_ill)')';
imagenames = {"1-1.png",'1-2.png','1-3.png','5.png','Lab2_5-1_2.jpg','Lab2_5-1_3.jpg','Lab2_5-1_4.jpg'};

for i=1:length(imagenames)
    image = imread(imagenames{i});
    [m,n,k] = size(image);
    im_reshaped = double(reshape(image, m*n,k));
    % sRGB to XYZ
    XYZ_source_image = srgb2xyz(im_reshaped);
    
    % Source illumination
    XYZ_source_ill = methodthree(image);
    LMS_source_ill = (M*(XYZ_source_ill)')';
    
    % Von Kries Chromatic Adaptation
    % Conversion from XYZ of source to XYZ of destination
    M_conversion = inv(M)*...
        [LMS_destination_ill(1)./LMS_source_ill(1) 0 0;...
        0 LMS_destination_ill(2)./LMS_source_ill(2) 0;...
        0 0 LMS_destination_ill(3)./LMS_source_ill(3)]*M;
    
    XYZ_destination_image = (M_conversion*XYZ_source_image')';
    RGB_destination = xyz2srgb(XYZ_destination_image);
    FinalImage = uint8(reshape(RGB_destination, [m, n, k]));

    figure;
    imshow(FinalImage)
    title("Final Image with von Kries")
    % Prepare the filename
    filename = sprintf('Method3_VK_im%d.png', i);
    % Save the final processed image
    imwrite(FinalImage, filename);
end
