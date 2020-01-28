close all; clear; clc;
load('RIRE_database');

%#ok<*AGROW>
fig1=figure;
set(fig1,'Units','Normalized','Position',[.1 .1 .8 .8]);
fig2=figure;
set(fig2,'Units','Normalized','Position',[.1 .1 .8 .8]);


donnees = {'CT'; 'PET' ; 'T1'; 'PD' };

for k=1:numel(donnees)
    tab_SSD = [];
    tab_CORR = [];
    tab_IM = [];
    I = PD;
    J_init = eval(donnees{k});    
    
    figure(fig1);
    for a=10:-1:0

        J = imtranslate(J_init,[2*a -a a/4]);
        J = imrotate(J,a,'crop');
        
        H=hist2(I,round(J)); % round pour garder valeurs enti�res (plus simple pour hist2)
        SSD = ssd(I,J);
        CORR = correlation(I,J);
        IM = mutual_information(H);
        
        tab_SSD = [tab_SSD SSD]; 
        tab_CORR = [tab_CORR CORR];
        tab_IM = [tab_IM IM];
        
        disp(['SSD=' num2str(SSD)]);
        disp(['correlation=' num2str(CORR)]);
        disp(['info mutuelle=' num2str(IM)]);   
        disp('-----------------');
        subplot(1,3,1)
        imagesc(I(:,:,3));axis equal;axis off;colormap gray;freezeColors; title('Densite de protons (IRM)');
        subplot(1,3,2)
        imagesc(J(:,:,3));axis equal;axis off;colormap gray;freezeColors; title(donnees{k});
        subplot(1,3,3)
        imagesc(log(H));axis equal;axis off;colormap jet;axis xy;
        drawnow;
    end
    figure(fig2);
    
    subplot(1,3,1);
    plot(tab_SSD);
    title('SSD')
    subplot(1,3,2);
    plot(tab_CORR);
    title('Correlation');
    subplot(1,3,3);
    plot(tab_IM);
    title('Information Mutuelle');
    pause
    
end




