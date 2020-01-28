clear;close all;clc;


load('TP2_donnees.mat');

I = double(Brain_MRI_3);
J = double(Brain_MRI_4);

epsilon_t = 5 * 10^-7;
epsilon_xy = 10.^-2;

p = 0;
q = 0;
theta = 0;
theta_old = theta+1;

[J_x,J_y] = grad_centre(J);
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));

energy = [ssd(J,I)];

dssd_dx = 1.1;
dssd_dy = 0;
dssd_dt = 1.1;

while(abs(dssd_dt) > 1 || abs(dssd_dx) + abs(dssd_dy) > 1)
    
    J_r = rigid_transformation(J,-theta, -p, -q);
    J_rx = rigid_transformation(J_x,-theta, -p ,-q);
    J_ry = rigid_transformation(J_y,-theta, -p ,-q);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
       
    diff = J_r - I;
    
    dssd_dt = 2 * sum(sum(diff.*(J_rx.*A + J_ry.*B)));
    dssd_dp = sum(sum(diff.*J_rx));
    dssd_dq = sum(sum(diff.*J_ry));
    
    theta = theta - epsilon_t*dssd_dt;
    p = p - epsilon_xy * dssd_dp;
    q = q - epsilon_xy * dssd_dq;
    
    energy = [energy, ssd(J_r,I)];
    
    subplot(1,2,1);
    imshow(0.5*J_r+0.5*I,[]);
    drawnow();
    subplot(1,2,2);
    plot(energy);
    title('Energie de l erreur')

    
    
end
