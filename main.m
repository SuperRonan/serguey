clear all; clf;
%% parameters
folder = 'data/factory/'; %what image

arg_pyramid = 60;
construct_until = 'minres'; % = 'minres' => arg_pyramid is the minimum resolution, else => arg_pyramid is the depth of the pyramid

similarity = 'im'; % 'im' or 'intersection' or 'union' or 'precision' or 'recall' or 'fmesure'(of edges)
    
dof = 'full'; % 'full' (trans + rot) or 'translation' (translation only)


%% load images
channels = load_channels(folder);
cropped_channels = channels;
for i = 1:3
    cropped_channels{i} = crop(channels{i}, 0.80);
end

channels{4} = cat(3, channels{1}, channels{2}, channels{3});
%imwrite(channels{4}, strcat(folder, 'rgb_naive.png'));

%% construct pyramid
pyramids = compute_pyramids(cropped_channels, arg_pyramid, construct_until);

%% registration
[p_g, q_g, p_b, q_b, a_g, a_b, s_g, s_b] = recalage(pyramids, similarity, dof);

g_registered = rigid_transformation(channels{2}, p_g, q_g, a_g, s_g);
b_registered = rigid_transformation(channels{3}, p_b, q_b, a_b, s_b);

channels{4} = cat(3, channels{1}, translation(channels{2}, p_g, q_g), translation(channels{3}, p_b, q_b));
cropped_channels{4} = cat(3, cropped_channels{1}, translation(cropped_channels{2}, p_g, q_g), translation(cropped_channels{3}, p_b, q_b));

%% write in file
imwrite(channels{4}, strcat(folder, 'rgb_',similarity,'_',dof,'_',int2str(arg_pyramid), '.png'));

%% display
figure;
for i=1:4
    subplot(2, 2, i);
    imshow(channels{i});
end

figure;
for i=1:4
    subplot(2, 2, i);
    imshow(cropped_channels{i});
end

