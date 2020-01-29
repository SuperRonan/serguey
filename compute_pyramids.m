function pyramids = compute_pyramids(channels, depth)
    pyramids = {}
    for i = 1:3
        pyramids{i}{1} = channels{i};
        for d = 2:depth
            pyramids{i}{d} = impyramid(pyramids{i}{d-1}, 'reduce');
        end
    end
end

