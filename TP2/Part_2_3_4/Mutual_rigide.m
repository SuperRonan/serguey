function [f] = Mutual_rigide(x,I,J,X,Y)

    p = x(1);
    q = x(2);
    theta = x(3);

    J_r = rigid_transformation(J,-theta, -p, -q);
    H=hist2(I,J_r);
    Pij = H/(sum(H(:)));
    Pi = sum(Pij,1); 
    Pj = sum(Pij,2); 
    TMP = Pij.*log2(Pij./(Pj*Pi));
    TMP(Pij==0)=0;
    IM = sum(TMP(:));
    
    f = 1- abs(TM);

    
end