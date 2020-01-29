function [f, g] = SSD_rigide(x,I,J,X,Y)
    [J_x,J_y] = grad_centre(J);
    p = x(1);
    q = x(2);
    theta = x(3);

    J_r = rigid_transformation(J,-theta, -p, -q);
    
    f = ssd(J_r, I);
    
    J_rx = rigid_transformation(J_x,-theta, -p, -q);
    J_ry = rigid_transformation(J_y,-theta, -p, -q);
    
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
    factor_1 = J_r - I;
    factor_2 = (J_rx .* A + J_ry .* B);
    
    grad_i = grad_centre(J_r);
    sum_dp = ((J_r - I) .* grad_i(:,:,1));
    sum_dq = ((J_r - I) .* grad_i(:,:,2));
    dp = 2 * sum(sum_dp(:));
    dq = 2 * sum(sum_dq(:));
    
    dtheta = 2 * sum(factor_1(:) .* factor_2(:));
    
    g = [dp dq dtheta];
    
end