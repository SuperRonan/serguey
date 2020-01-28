function H=hist2(A,B)
% on suppose que les images sont de la meme taille et que les intensites
% sont comprises entre 0 et 255

H = zeros(256,256);
for k=1:numel(A)
    i = B(k)+1;
    j = A(k)+1;
    H(i,j) = H(i,j)+1;
end

