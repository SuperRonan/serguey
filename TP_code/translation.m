function It = translation(I,p,q)
    T = [1 0 0; 
         0 1 0; 
         q p 1];
    tform = affine2d(T);
    
    Rout = imref2d(size(I)); % pour garder le meme repere que l'image initiale
    
    It = imwarp(I,tform,'OutputView',Rout);
    
    
