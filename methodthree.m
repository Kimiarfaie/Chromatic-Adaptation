function XYZ = methodthree(input)
im = input;
im = double(im);
avgRed = mean(mean(im(:,:,1), 1), 2);
avgGreen = mean(mean(im(:,:,2), 1), 2);
avgBlue = mean(mean(im(:,:,3), 1), 2);
averageRGB = [avgRed, avgGreen, avgBlue];
averageXYZ = srgb2xyz(averageRGB);
ave_x = averageXYZ(1)./(averageXYZ(1)+averageXYZ(2)+averageXYZ(3));
ave_y = averageXYZ(2)./(averageXYZ(1)+averageXYZ(2)+averageXYZ(3));

%Now, we have ave_x, ave_y, and Y=100

X = (ave_x./ave_y)*100;
Y = 100;
Z = ((1-ave_x-ave_y)./ave_y)*100;
XYZ = [X Y Z];
