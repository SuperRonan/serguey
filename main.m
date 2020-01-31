clear all; clf;

folder = 'data/alleia/';


channels = load_channels(folder);
cropped_channels = channels;
for i = 1:3
    cropped_channels{i} = crop(channels{i}, 0.6);
end

channels{4} = cat(3, channels{1}, channels{2}, channels{3});
%channels{2} = rigid_transformation(channels{2}, 0, 0, -pi/5, 1);
%channels{3} = rigid_transformation(channels{3}, 0, 10, pi/5, 1);


imwrite(channels{4}, strcat(folder, 'rgb_naive.png'));


pyramids = compute_pyramids(cropped_channels, 50, 'minres');


[p_g, q_g, p_b, q_b, a_g, a_b, s_g, s_b] = recalage(pyramids, "edge", "full");

g_registered = rigid_transformation(channels{2}, p_g, q_g, a_g, s_g);
b_registered = rigid_transformation(channels{3}, p_b, q_b, a_b, s_b);

channels{4} = cat(3, channels{1}, g_registered, b_registered);

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





