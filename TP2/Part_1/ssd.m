function [ res ] = ssd(I, J)
%SSD Summary of this function goes here
%   Detailed explanation goes here

res = sum(((I(:) - J(:)).^2));

end

