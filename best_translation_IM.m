% computes (p,q) = argmin IM(I(x,y), Y(x+p, y+q))
function [best_p, best_q] = best_translation_IM(I, Y, range_p, range_q, start_p, start_q)
    best_p = 0;
    best_q = 0;
    best_IM = 0;
    for p = -range_p/2:range_p/2
        for q = -range_q/2:range_q/2
            tmp = translation(Y,start_p+p,start_q+q);
            IM = mutual_information(hist2(I, tmp));
            if IM > best_IM
                best_IM = IM;
                best_p = p + start_p;
                best_q = q + start_q;
            end
        end
    end

end

