clear;close all;clc;


load('TP2_donnees.mat');

I = double(Brain_MRI_1);
J = double(Brain_MRI_3);

epsilon = 5 * 10^-7;

theta = 0;
theta_old = theta+1;

[J_x,J_y] = grad_centre(J);
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));

energy = [ssd(J,I)];

while(abs(theta-theta_old)>5*1e-4)
    
    J_r = rotation(J,-theta);
    J_rx = rotation(J_x,-theta);
    J_ry = rotation(J_y,-theta);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
        
    dssd_dt= 2 * sum(sum((J_r - I).*(J_rx.*A + J_ry.*B)));
    theta_old = theta;
    theta = theta - epsilon*dssd_dt;
    
    energy = [energy, ssd(J_r,I)];
    
    subplot(1,2,1);
    imshow(0.5*J_r+0.5*I,[]);
    drawnow();
    subplot(1,2,2);
    plot(energy);
    title('Energie de l erreur')

    
    
end
