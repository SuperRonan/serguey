function [p_g, q_g, p_b, q_b] = recalage_IM(pyramids)
    [range_p, range_q] = size(pyramids{1}{end});
    p_g = 0; q_g = 0; p_b = 0;q_b= 0; start_q_g = 0; start_p_g = 0; start_q_b =0; start_p_b = 0;
    for depth = numel(pyramids{1}):-1:1
        disp(depth);
        [p_g, q_g] = best_translation_IM(pyramids{1}{depth}, pyramids{2}{depth}, range_p, range_q, start_p_g, start_q_g);
        [p_b, q_b] = best_translation_IM(pyramids{1}{depth}, pyramids{3}{depth}, range_p, range_q, start_p_b, start_q_b);
        start_p_g = 2*p_g;
        start_q_g = 2*q_g;
        start_p_b = 2*p_b;
        start_q_b = 2*q_b;
    end
    
end

