function H=hist2(A,B)
% on suppose que les images sont de la meme taille et que les intensites
% sont comprises entre 0 et 255

H = zeros(256,256);
for k=1:numel(A)
    i = B(k);
    i = i+1;
    j = A(k);
    j = j+1;
    H(i,j) = H(i,j)+1;
end

