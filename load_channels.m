function channels = load_channels(folder)
channels = {};
channels{1} = imread(strcat(folder, 'r.png'));
channels{2} = imread(strcat(folder, 'g.png'));
channels{3} = imread(strcat(folder, 'b.png'));

for i=1:3
    channel = channels{i};
    if size(channel, 3) == 3
        channel = channel(:, :, i);
    end
    channels{i} = channel;
end

max_size = [1, 1];
for i=1:3
    max_size = max(max_size, size(channels{i}));
end

for i=1:3
    channel = channels{i};
    tmp = channel;
    channel = zeros(max_size);
    channel(1:size(tmp, 1), 1:size(tmp, 2)) = tmp;
    %channels{i} = channel ./ 255;
end

end

