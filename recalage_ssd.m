% Computes the rigid transformation between I and J by SSD gradient
% descent. Returns J rigidly transformed to fit I.

function J_res = recalage_ssd(I,J, eps)
    epsilon_t = 5 * 10^-10;
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
    
    diff_energy = 1000000.0;
    
    N = 0;

    while( (N < 1 ||  diff_energy > eps) && (abs(dssd_dt) > 1 || abs(dssd_dx) + abs(dssd_dy) > 1) )
        pause(1);
        N = N+1;
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
        
        energy_next = ssd(J_r,I);
        energy_last = energy(end);
        diff_energy = abs(energy_last - energy_next);
        energy = [energy, energy_next];

        subplot(1,2,1);
        imshow(0.5*J_r+0.5*I,[]);
        drawnow();
        subplot(1,2,2);
        plot(energy);
        title('Energie de l erreur')

        

    end
    
    J_res = rigid_transformation(J,-theta, -p, -q);

end

