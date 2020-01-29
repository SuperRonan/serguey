close all; clear; clc;

for k=1:4
    I =double(imread(['I' num2str(k) '.jpg']));
    J =double(imread(['J' num2str(k) '.jpg']));
    
    H=hist2(I,J);
    SSD = ssd(I,J);
    CORR = correlation(I,J);
    IM = mutual_information(H);
    
    disp(['SSD=' num2str(SSD)]);
    disp(['correlation=' num2str(CORR)]);
    disp(['info mutuelle=' num2str(IM)]);
    disp('-----------------');
    subplot(1,3,1)
    imagesc(I);axis equal;axis off;colormap gray;freezeColors;
    subplot(1,3,2)
    imagesc(J);axis equal;axis off;colormap gray;freezeColors;
    subplot(1,3,3)
    imagesc(log(H));axis equal;axis off;axis xy;colormap jet;
    pause
end
