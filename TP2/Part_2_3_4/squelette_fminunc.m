clear; close all; clc;

load('TP2_donnees');
I = Brain_MRI_1;
J = Brain_MRI_4;
%I = Sclerose_en_Plaques_M0;
%J = Sclerose_en_Plaques_M3;
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));

% on creee un "pointeur" de fonction pour "cacher" les arguments autres que les parametres a optmiser
% il faut donc ecrire une fonction SSD_rigide qui calcule l'energie (ici : SSD) et le gradient correspondant a un probleme de recalage (deux images I et J)
%f = @(x)SSD_rigide(x,I,J,X,Y);
%f = @(x)Correl_rigide(x,I,J,X,Y);
f = @(x)Mutual_rigide(x,I,J,X,Y);


%parametres de recalage (theta p q) initiaux
param_old = [0 0 0];

error = 10000;

options = optimset('GradObj','off');
options.TolX = 1e-10;
options.Display = 'iter';

while error > 0

[new_param,fval] = fminunc(f,param_old,options)

error = norm(param_old - new_param);

%visualisation du resultat (A FAIRE)
subplot(1,3,1);
imshow(I);

subplot(1,3,2);
imshow(J);

J_r = rigid_transformation(J,-new_param(3), -new_param(1), -new_param(2));
imshow(J_r);

subplot(1,3,3);
imshow(abs(J_r - I), []);

param_old = new_param;

end



