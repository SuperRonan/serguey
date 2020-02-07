function [p_g, q_g, p_b, q_b, a_g,  a_b, s_g, s_b] = recalage(pyramids, type, dof)
    if nargin ==1
        type = "im";
        dof ="full";
    end
    
    if nargin ==2
        dof ="full";
    end
    
    if(dof=="full")
        [p_g, q_g, p_b, q_b, a_g,  a_b, s_g, s_b] = recalage_transform(pyramids, type);
    else    
        [p_g, q_g, p_b, q_b, a_g,  a_b, s_g, s_b] = recalage_translation(pyramids, type);
    end
    
   %[p_g, q_g, p_b, q_b, a_g,  a_b, s_g, s_b] = recalage_translation_IM(pyramids);
   %[p_g, q_g, p_b, q_b, a_g,  a_b, s_g, s_b] = recalage_transform_IM(pyramids);
end

function [p_g, q_g, p_b, q_b, a_g,  a_b, s_g, s_b] = recalage_translation(pyramids, type)
    [range_p, range_q] = size(pyramids{1}{end}{1});
    range_p = range_p/10;
    range_q = range_q/10;
    p_g = 0; q_g = 0; p_b = 0;q_b= 0; start_q_g = 0; start_p_g = 0; start_q_b =0; start_p_b = 0;
    for depth = numel(pyramids{1}):-1:1
        disp(depth);
        
        [p_g, q_g] = best_translation(pyramids{1}{depth}, pyramids{2}{depth}, range_p, range_q, start_p_g, start_q_g, type);
        [p_b, q_b] = best_translation(pyramids{1}{depth}, pyramids{3}{depth}, range_p, range_q, start_p_b, start_q_b, type);
        
        start_p_g = 2*p_g;
        start_q_g = 2*q_g;
        start_p_b = 2*p_b;
        start_q_b = 2*q_b;
        range_p = 4;
        range_q = 4;
    end
    a_g =0; a_b =0; s_g = 1; s_b = 1;
    
end

function [p_g, q_g, p_b, q_b, a_g,  a_b, s_g, s_b] = recalage_transform(pyramids, type)
    [range_p, range_q] = size(pyramids{1}{end}{1});
    range_p = range_p/10;
    range_q = range_q/10;
    range_s = 0.5;
    range_a = pi/8;
    
    p_g = 0; q_g = 0; p_b = 0;q_b = 0; start_q_g = 0; start_p_g = 0; start_q_b = 0; start_p_b = 0;
    a_g =0; a_b =0; start_a_g = 0; start_a_b = 0;
    s_g = 1; s_b = 1; start_s_g = 1; start_s_b = 1;
    first = true;
    for depth = numel(pyramids{1}):-1:1
        disp(depth);
        
        [p_g, q_g, a_g, s_g] = best_transform(pyramids{1}{depth}, pyramids{2}{depth}, range_p, range_q, range_a, range_s, start_p_g, start_q_g, start_a_g, start_s_g, type);
        [p_b, q_b, a_b, s_b] = best_transform(pyramids{1}{depth}, pyramids{3}{depth}, range_p, range_q, range_a, range_s, start_p_b, start_q_b, start_a_b, start_s_b, type);
        
        start_p_g = 2*p_g;
        start_q_g = 2*q_g;
        start_p_b = 2*p_b;
        start_q_b = 2*q_b;
        start_a_g = a_g;
        start_a_b = a_b;
        if first
            start_a_g = 0;
            start_a_b = 0;
        end
        range_a = range_a/2.0;
        range_s = range_s/10.0;
        range_p = 4;
        range_q = 4;
        first = false;
    end
   
    
end



