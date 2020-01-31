clear all; clf;
folder = 'data/church/';

channels = load_channels(folder);
cropped_channels = channels;
for i = 1:3
    cropped_channels{i} = crop(channels{i}, 0.6);
end

channels{4} = cat(3, channels{1}, channels{2}, channels{3});




imwrite(channels{4}, strcat(folder, 'rgb_naive.png'));

pyramids = compute_pyramids(cropped_channels, 50, 'minres');
[p_g, q_g, p_b, q_b] = recalage_IM(pyramids);
    
channels{4} = cat(3, channels{1}, translation(channels{2}, p_g, q_g), translation(channels{3}, p_b, q_b));

imwrite(channels{4}, strcat(folder, 'rgb_recale_IM.png'));

figure;
for i=1:4
    subplot(2, 2, i);
    imshow(channels{i});
end

figure;
for i=1:3
    subplot(2, 2, i);
    imshow(cropped_channels{i});
end


