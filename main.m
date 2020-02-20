clear all; clf;
warning('off', 'Images:initSize:adjustingMag');
%% parameters
folder = 'data/garden/'; %what image

arg_pyramid = 60;
construct_until = 'minres'; % = 'minres' => arg_pyramid is the minimum resolution, else => arg_pyramid is the depth

similarity = 'im'; % 'im' or 'intersection' or 'union' or 'precision' or 'recall' or 'fmesure'(of edges)

dof = 'full'; % full or translation

do_demons = true;


%% load images
channels = load_channels(folder);
cropped_channels = channels;
for i = 1:3
    cropped_channels{i} = crop(channels{i}, 0.80);
end

channels{4} = cat(3, channels{1}, channels{2}, channels{3});
%channels{2} = rigid_transformation(channels{2}, 0, 0, -pi/5, 1);
%channels{3} = rigid_transformation(channels{3}, 0, 10, pi/5, 1);


%imwrite(channels{4}, strcat(folder, 'rgb_naive.png'));

%% construct pyramid
pyramids = compute_pyramids(cropped_channels, arg_pyramid, construct_until);

%% registration
[p_g, q_g, p_b, q_b, a_g, a_b, s_g, s_b] = recalage(pyramids, similarity, dof);

g_registered = rigid_transformation(channels{2}, p_g, q_g, a_g, s_g);
b_registered = rigid_transformation(channels{3}, p_b, q_b, a_b, s_b);

channels{4} = cat(3, channels{1}, g_registered, b_registered);
channels{2} = g_registered;
channels{3} = b_registered;
cropped_channels{4} = cat(3, cropped_channels{1}, translation(cropped_channels{2}, p_g, q_g), translation(cropped_channels{3}, p_b, q_b));

%% write in file
imwrite(channels{4}, strcat(folder, 'rgb_recale_IM.png'));


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

%% Demons
if do_demons
    disp('demons');
    R = channels{1};
    figure;
    [G, gsx, gsy, gvx, gvy] = demons(channels{1}, channels{2});
    G = imresize(G, size(R));
    [B, bsx, bsy, bvx, bvy] = demons(channels{1}, channels{3});
    B = imresize(B, size(R));
    
    demons_channels = {R, G, B, cat(3, R, G, B)};
    figure;
    for i=1:4
        subplot(2, 2, i);
        imshow(demons_channels{i});
    end
    imwrite(demons_channels{4}, strcat(folder, 'rgb_demons.png'));
end

