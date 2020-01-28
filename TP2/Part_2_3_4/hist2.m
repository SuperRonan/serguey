function H=hist2(A,B, samples)
% on suppose que les images sont de la meme taille et que les intensites
% sont comprises entre 0 et 255

if (nargin == 2)
    samples = 256;
end

min_A = min(A(:));
max_A = max(A(:));
min_B = min(B(:));
max_B = max(B(:));

min_min = min(min_A, min_B);
max_max = max(max_A, max_B);

A = (A - min_min) / (max_max - min_min);
B = (B - min_min) / (max_max - min_min);

A = int32(A * samples);
B = int32(B * samples);


H = zeros(samples,samples);
for k=1:numel(A)
    i = min(B(k)+1, samples);
    j = min(samples, A(k)+1);
    H(i,j) = H(i,j)+1;
end

