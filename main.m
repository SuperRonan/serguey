folder = 'data/factory/';

channels = load_channels(folder);

channels{4} = cat(3, channels{1}, channels{2}, channels{3});

figure;
for i=1: 4
    subplot(2, 2, i);
    imshow(channels{i});
end

imwrite(channels{4}, strcat(folder, 'rgb.png'));