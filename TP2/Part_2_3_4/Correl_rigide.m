function [f] = Correl_rigide(x,I,J,X,Y)

    p = x(1);
    q = x(2);
    theta = x(3);

    J_r = rigid_transformation(J,-theta, -p, -q);
    
    f = 1- abs(corr2(I(:), J_r(:)));

    
end