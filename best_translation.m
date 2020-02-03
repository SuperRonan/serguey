% computes (p,q) = argmin IM(I(x,y), Y(x+p, y+q))
function [best_p, best_q, best_a, best_s] = best_translation(I, Y, range_p, range_q, start_p, start_q, type)
    best_p = 0;
    best_q = 0;
    best_score = 0;
    for p = -range_p/2:range_p/2
        for q = -range_q/2:range_q/2
            
%             if(type=="im")
%                 tmp = translation(Y{1},start_p+p,start_q+q);
%                 score = mutual_information(hist2(I{1}, tmp));
%             else
%                 tmp = translation(Y{1},start_p+p,start_q+q);
%                 score = image_intersection(I{1},tmp);
%             end
%             
            if strcmpi(type, 'im')
                index = 1;
                tmp = translation(Y{index},start_p+p,start_q+q);
                score = mutual_information(hist2(I{index}, tmp));
            elseif strcmpi(type, 'fmesure') || strcmpi(type, 'intersection') || strcmpi(type, 'union') || strcmpi(type, 'precision') || strcmpi(type, 'precision')
                index = 2;
                tmp = translation(Y{index},start_p+p,start_q+q);
                [inter, union, precision, recall, fmesure] = logical_metrics(I{index}, tmp);
                if(strcmpi(type, 'fmesure'))
                    score = fmesure;
                elseif strcmpi(type, 'intersection')
                    score = inter;
                elseif strcmpi(type, 'union')
                    score = union;
                elseif strcmpi(type, 'precision')
                    score = precision;
                elseif strcmpi(type, 'recall')
                    score = recall;
                end
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