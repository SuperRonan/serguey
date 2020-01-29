clear;close all;clc;
load('TP2_donnees.mat')

J = double(Brain_MRI_1);
I = double(Brain_MRI_4);

epsilon_theta = 0.000001;
epsilon_translate = epsilon_theta;

theta = 0;
theta_old = theta+1;
dp = 10;
dq = 10;
p = 0;
q = 0;
 
[J_x,J_y] = grad_centre(J);
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));
pause;
figure;
subplot(1,4,1);
imshow(I);

old_param = [1 1 1];
new_param = [0 0 0];
tab_SSD = [];
params = [];

while(norm(new_param-old_param)>1e-7)
    
    J_r = rigid_transformation(J,-theta, -p, -q);
    J_rx = rigid_transformation(J_x,-theta, -p, -q);
    J_ry = rigid_transformation(J_y,-theta, -p, -q);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
    factor_1 = J_r - I;
    factor_2 = (J_rx .* A + J_ry .* B);
    
    d_theta = 2 * sum(factor_1(:) .* factor_2(:));
    
    theta_old = theta;
    theta = theta - epsilon_theta*d_theta;
    
    grad_i = grad_centre(J_r);[J_x,J_y] = grad_centre(J);
    sum_dp = ((J_r - J) .* 
    (:,:,1));
    sum_dq = ((J_r - J) .* grad_i(:,:,2));
    dSSD_dp = 2 * sum(sum_dp(:));
    dSSD_dq = 2 * sum(sum_dq(:));
        
    dp = -epsilon_translate * dSSD_dp;
    dq = -epsilon_translate * dSSD_dq;
        
    p = p + dp;
    q = q + dq;
    
    old_param = new_param;
    new_param = [p q theta];
    
    params = [params; new_param];
    
    subplot(1,4,4);
    plot3(params(:,1), params(:,2), params(:,3));
    
    disp([num2str(new_param) '  |  ' num2str(new_param-old_param)]);
    tab_SSD = [tab_SSD ssd(J_r,I)]; 
    subplot(1,4,3);
    plot(tab_SSD);
    title('SSD')
    %disp(ssd(J_r,I));

    subplot(1,4,2);
    imshow(abs(J_r - I), []);
    drawnow;
end
