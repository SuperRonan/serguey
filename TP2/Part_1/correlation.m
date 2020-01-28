function [ res ] = correlation( I, J)
%CORRELATION Summary of this function goes here
%   Detailed explanation goes here

res = corr2(I(:), J(:));


end

