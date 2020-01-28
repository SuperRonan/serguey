function J = rigid_transformation(I,theta,p,q)
    T = [1 0 0; 
         0 1 0; 
         q p 1];
     R = [ cos(theta)   -sin(theta)   0;
           sin(theta)    cos(theta)   0;
               0            0         1];
tform = affine2d(T*R);

Rout = imref2d(size(I)); % pour garder le même repère que l'image initiale

J = imwarp(I,tform,'OutputView',Rout);
