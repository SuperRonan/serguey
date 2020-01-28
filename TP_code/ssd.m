function [ res ] = ssd( I,J )

    X = I(:) - J(:);
    res = sum(X.^2);

end

