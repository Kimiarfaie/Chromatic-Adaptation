function RGB_illuminant = methodone(input)
im = input;
[M,N,K] = size(im);
im = double(reshape(im, M*N,K));
% sRGB to XYZ
XYZ = srgb2xyz(im);
% XYZ to Cone space
M_HPE = [0.38971, 0.69989, -0.07868; -0.22981, 1.18340, 0.04641; 0 0 1];

LMS = (M_HPE*XYZ')';

%Achromatic channel
A = 2*LMS(:,1)+LMS(:,2)+(1/20)*LMS(:,3);

% Let's find where in the image is the max A
A_reshaped = reshape(A, [M, N]);
[maxColumnValues, rowIndices] = max(A_reshaped);  % Maximums of each column
[maxValue, col] = max(maxColumnValues);  % Overall maximum and its column
row = rowIndices(col);  % The row index of the overall maximum

% Let's find the RGB value of that pixel
RGB_illuminant = input(row, col, :);

