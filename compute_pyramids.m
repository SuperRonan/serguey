function pyramids = compute_pyramids(channels, arg, option)
    pyramids = {};
    
    for i = 1:3
        pyramids{i}{1} = channels{i};
        
        if (option == 'minres')
            M = min(size(channels{i}));
            d = 2;
            while M > arg
                pyramids{i}{d} = impyramid(pyramids{i}{d-1}, 'reduce');
                M = min(size( pyramids{i}{d}));
                d = d+1;
            end 
        else
            for d = 2:arg
                pyramids{i}{d} = impyramid(pyramids{i}{d-1}, 'reduce');
            end
        end

    end
end

