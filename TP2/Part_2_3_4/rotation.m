function Ir = rotation(I, theta)
R = [ cos(theta)   -sin(theta)   0;
      sin(theta)    cos(theta)   0;
          0            0         1];
      
tform = affine2d(R);

Rout = imref2d(size(I)); % pour garder le meme repere que l'image initiale

Ir = imwarp(I,tform,'OutputView',Rout);
