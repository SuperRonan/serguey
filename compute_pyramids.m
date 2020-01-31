function pyramids = compute_pyramids(channels, arg, option_minres)
    pyramids = {};
    
    for i = 1:3

        pyramids{i}{1} = {};
        pyramids{i}{1}{1} = channels{i};
        pyramids{i}{1}{2} = edge(channels{i},'Canny');
        
        if (option_minres == 'minres')
            M = min(size(channels{i}));
            d = 2;
            while M > arg
                pyramids{i}{d} = {}
                pyramids{i}{d}{1} = impyramid(pyramids{i}{d-1}{1}, 'reduce');
                pyramids{i}{d}{2} = edge(pyramids{i}{d}{1},'Canny');
                M = min(size( pyramids{i}{d}{1}));
                d = d+1;
            end 
        else
            for d = 2:arg
                pyramids{i}{d} = {}
                pyramids{i}{d}{1} = impyramid(pyramids{i}{d-1}{1}, 'reduce');
                pyramids{i}{d}{2} = edge(pyramids{i}{d}{1},'Canny');
            end
        end

    end
end

