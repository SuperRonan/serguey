% computes (p,q) = argmin IM(I(x,y), Y(x+p, y+q))
function [best_p, best_q, best_a, best_s] = best_translation(I, Y, range_p, range_q, start_p, start_q, type)
    best_p = 0;
    best_q = 0;
    best_score = 0;
    for p = -range_p/2:range_p/2
        for q = -range_q/2:range_q/2
            
            if(type=="im")
                tmp = translation(Y{1},start_p+p,start_q+q);
                score = mutual_information(hist2(I{1}, tmp));
            else
                tmp = translation(Y{1},start_p+p,start_q+q);
                score = image_intersection(I{1},tmp);
            end
            
            if score > best_score
                best_score = score;
                best_p = p + start_p;
                best_q = q + start_q;
            end
        end
    end
    best_a = 0.0;
    best_s=1.0;

end