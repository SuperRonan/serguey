load('TP2_donnees.mat');


 J = double(Brain_MRI_1);
 
 I = double(Brain_MRI_2);

 epsilon = 10.^-2;
 
 
 p = 0;
 q = 0;

 img = translation(I,-p, -q);
 diff = img - J;
 grad = grad_centre(img);
 dssd_dp = sum(sum(diff.*grad(:,:,1)));
 dssd_dq = sum(sum(diff.*grad(:,:,2)));
 energy = [ssd(img,I)];
 
 while(abs(dssd_dp) + abs(dssd_dq)> 1)
    p = p -  epsilon * dssd_dp
    q = q - epsilon * dssd_dq
    
    img = translation(I,-p, -q);
    diff = img - J;
    grad = grad_centre(img);
    dssd_dp = sum(sum(diff.*grad(:,:,1)));
    dssd_dq = sum(sum(diff.*grad(:,:,2)));
    energy = [energy, ssd(img,J)];
    
    subplot(1,4,1);
    imshow(diff.*grad(:,:,1), []);
    subplot(1,4,2);
    imshow(diff.*grad(:,:,2), []);
    subplot(1,4,3);
    imshow(0.5*img+0.5*J,[]);
    drawnow;
    subplot(1,4,4);
    plot(energy);
    title('Energie de l erreur');
    drawnow;
    
 end
 
 
 
 
 
 
 