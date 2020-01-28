function [ coeff ] = Correlation( I, J )

    coeff = corr2(I(:),J(:));

end

