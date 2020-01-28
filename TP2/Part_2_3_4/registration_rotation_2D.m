clear;close all;clc;
load('TP2_donnees.mat')

J = double(Brain_MRI_1);
I = double(Brain_MRI_3);

epsilon = 0.0000003;

theta = 0;
theta_old = theta+1;
 
[J_x,J_y] = grad_centre(J);
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));
pause;
figure;
subplot(1,2,1);
imshow(I);

while(abs(theta-theta_old)>1e-7)
    
    J_r = rotation(J,-theta);
    J_rx = rotation(J_x,-theta);
    J_ry = rotation(J_y,-theta);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
    factor_1 = J_r - I;
    factor_2 = (J_rx .* A + J_ry .* B);
    
    d_theta = 2 * sum(factor_1(:) .* factor_2(:));
    
    theta_old = theta;
    theta = theta - epsilon*d_theta;
    subplot(1,2,2);
    imshow(abs(J_r - I), []);
    drawnow;
end
