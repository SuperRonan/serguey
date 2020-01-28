close all; clear; clc;
load('TP2_donnees.mat')

demo = 'translate';
I =double(Brain_MRI_1);
epsilon = 0.01;
if( strcmp(demo ,'translate'))
    J = double(Brain_MRI_2);
    dp = 10;
    dq = 10;
    p = 0;
    q = 0;
    figure;
    subplot(1,3,1)
    imshow(I)
    while (dp^2 + dq^2 >= 0.001)
        trans_i = translation(I, -p, -q);
        grad_i = grad_centre(trans_i);
        sum_dp = ((trans_i - J) .* grad_i(:,:,1));
        sum_dq = ((trans_i - J) .* grad_i(:,:,2));
        dSSD_dp = 2 * sum(sum_dp(:));
        dSSD_dq = 2 * sum(sum_dq(:));
        
        dp = -epsilon * dSSD_dp;
        dq = -epsilon * dSSD_dq;
        
        p = p + dp
        q = q + dq
        subplot(1,3,2);
        imshow(trans_i + J,[]);
        subplot(1,3,3);
        imshow(abs(trans_i - J),[]);
        drawnow;
    end 
end
