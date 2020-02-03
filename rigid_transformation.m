function J = rigid_transformation(I,p,q, theta, s)

    [W,H] = size(I);
    T1 = [1 0 0; 
         0 1 0; 
         -H/2 -W/2 1];
    T2 = [1 0 0; 
          0 1 0; 
          H/2 W/2 1];
    T = [1 0 0;
         0 1 0; 
         q p 1];
    S= [s 0 0;
        0 s 0;
        0 0 s];
    R = [ cos(theta)   -sin(theta)  0;
          sin(theta)   cos(theta)   0;
          0            0            1];
    tform = affine2d(T1*R*T2*T*S);

    Rout = imref2d(size(I)); % pour garder le même repère que l'image initiale

    J = imwarp(I,tform,'OutputView',Rout);

