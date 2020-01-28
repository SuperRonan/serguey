function [fx,fy,fz] = grad_centre(M)
% calcule le gradient de M (1D ou 2D ou 3D)
% conditions aux bords : miroir
% schema de discretisation : différences centrées



nbdims = 2;
if size(M,1)==1 || size(M,2)==1  %1D
    nbdims = 1;
end
if size(M,1)>1 && size(M,2)>1 && size(M,3)>1  %3D
    nbdims = 3;
end


fx = ( M([2:end end],:,:)-M([1 1:end-1],:,:) )/2;
% bords
fx(1,:,:) = M(2,:,:)-M(1,:,:);
fx(end,:,:) = M(end,:,:)-M(end-1,:,:);
if nbdims>=2
    fy = ( M(:,[2:end end],:)-M(:,[1 1:end-1],:) )/2;
    % bords
    fy(:,1,:) = M(:,2,:)-M(:,1,:);
    fy(:,end,:) = M(:,end,:)-M(:,end-1,:);
end
if nbdims>=3
    fz = ( M(:,:,[2:end end])-M(:,:,[1 1:end-1]) )/2;
    % bords
    fz(:,:,1) = M(:,:,2)-M(:,:,1);
    fz(:,:,end) = M(:,:,end)-M(:,:,end-1);
end

if nargout==1
    if nbdims==2
        fx = cat(3,fx,fy);
    elseif nbdims==3
        fx = cat(4,fx,fy,fz);
    end
end