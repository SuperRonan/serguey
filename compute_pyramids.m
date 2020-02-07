function pyramids = compute_pyramids(channels, arg, option_minres)
    pyramids = {};
    method = 'Canny';
    for i = 1:3
        M = min(size(channels{i}));
        pyramids{i}{1} = {};
        pyramids{i}{1}{1} = channels{i};
        pyramids{i}{1}{2} = edge(channels{i},method,[], M/100.0);
       
        if (option_minres == 'minres')
            d = 2;
            while M > arg
                pyramids{i}{d} = {};
                pyramids{i}{d}{1} = impyramid(pyramids{i}{d-1}{1}, 'reduce');
                pyramids{i}{d}{2} = edge(pyramids{i}{d}{1},method,[],M/100.0);
                M = min(size( pyramids{i}{d}{1}));
                d = d+1;
            end 
        else      
            for d = 2:arg
                pyramids{i}{d} = {};
                pyramids{i}{d}{1} = impyramid(pyramids{i}{d-1}{1}, 'reduce');
                pyramids{i}{d}{2} = edge(pyramids{i}{d}{1},method,[],M/100.0);
                M = min(size( pyramids{i}{d}{1}));
            end
        end

    end
end

