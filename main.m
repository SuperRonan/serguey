image_folder = 'data/alleia/';

R = imread(strcat(image_folder, 'r.png'));
G = imread(strcat(image_folder, 'g.png'));
B = imread(strcat(image_folder, 'b.png'));

channels = {single(R), single(G), single(B)};
for i=1:3
    channel = channels{i};
    channel = channel(:, :, i);
    channels{i} = channel;
end

channels{4} = cat(3, channels{1}, channels{2}, channels{3});

figure;
for i=1:4
    subplot(1, 4, i);
    imshow(channels{i});
end

I = channels{1};
J = rigid_transformation(channels{1}, 0.5, -10, 10);
R = recalage_ssd(I, J, 0.1);
