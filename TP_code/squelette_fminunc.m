clear; close all; clc;

load('TP4_donnees');
I = Brain_MRI_1;
J = Brain_MRI_4;
%I = Sclerose_en_Plaques_M0;
%J = Sclerose_en_Plaques_M3;
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));

% on creee un "pointeur" de fonction pour "cacher" les arguments autres que les parametres a optmiser
% il faut donc ecrire une fonction SSD_rigide qui calcule l'energie (ici : SSD) et le gradient correspondant a un probleme de recalage (deux images I et J)
f = @(x)SSD_rigide(x,I,J,X,Y);


%parametres de recalage (theta p q) initiaux
param = [0 0 0];


options = optimset('GradObj','on');
options.Display = 'iter';
[param,fval] = fminunc(f,param,options)

%visualisation du resultat (A FAIRE)