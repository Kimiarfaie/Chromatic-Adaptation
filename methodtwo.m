function RGBValues = methodtwo(image)
    % Display the image
    figure;
    imshow(image);
    title('Click on a white object in the image');
    
    % User selects a point
    [x, y] = ginput(1); % Get one point
    x = round(x); % Round the coordinates to ensure they are valid indices
    y = round(y);
    
    % Get the RGB values at the selected point
    RGBValues = squeeze(image(y, x, :))'; % Use squeeze to convert from 1x1x3 to 1x3 array
    
    % Display the RGB values
    fprintf('RGB values at the selected point: R=%d, G=%d, B=%d\n', RGBValues(1), RGBValues(2), RGBValues(3));
end
