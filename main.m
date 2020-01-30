clear all; clf;
folder = 'data/church/';

channels = load_channels(folder);


channels{4} = cat(3, channels{1}, channels{2}, channels{3});

figure;

for i=1:4
    subplot(2, 2, i);
    imshow(channels{i});
end

imwrite(channels{4}, strcat(folder, 'rgb_naive.png'));

pyramids = compute_pyramids(channels, 10);
[p_g, q_g, p_b, q_b] = recalage_IM(pyramids);

channels{4} = cat(3, channels{1}, translation(channels{2}, p_g, q_g), translation(channels{3}, p_b, q_b));

imwrite(channels{4}, strcat(folder, 'rgb_recale_IM.png'));


