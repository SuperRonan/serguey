function cropped = crop(image, scale)
    if nargin == 1
        scale = 0.9;
    end
    assert(scale <= 1);
    resolution = size(image); resolution = int32(resolution(1:2));
    cropped_resolution = int32(resolution * scale);
    diff = resolution - cropped_resolution;
    
    top_left = int32(max((diff / 2), int32([1, 1])));
    bottom_right = top_left + cropped_resolution;
    
    cropped = image(top_left(1):bottom_right(1), top_left(2):bottom_right(2), :, :);
end

