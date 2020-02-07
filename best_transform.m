% computes (p,q) = argmin IM(I(x,y), Y(x+p, y+q))
function [best_p, best_q, best_a, best_s] = best_transform(I, Y, range_p, range_q, range_a, range_s, start_p, start_q, start_a, start_s, type)
    best_p = 0;
    best_q = 0;
    best_a = 0;
    best_s = 1;
    best_score = 0;
    
    %for s = 1-range_s:range_s:1+range_s
        for a = -range_a/2:range_a/4:range_a/2
            for p = -range_p/2:range_p/2
                for q = -range_q/2:range_q/2
                    %fprintf('%d/%d/%d/%d\n',s,a,p,q);
                    if strcmpi(type, 'im')
                        index = 1;
                        tmp = rigid_transformation(Y{index},start_p+p,start_q+q, start_a +a, 1);
                        score = mutual_information(hist2(I{index}, tmp));
                    elseif strcmpi(type, 'fmesure') || strcmpi(type, 'intersection') || strcmpi(type, 'union') || strcmpi(type, 'precision') || strcmpi(type, 'recall')
                        index = 2;
                        tmp = rigid_transformation(Y{index},start_p+p,start_q+q, start_a +a, 1);
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
                        disp(score);
                        best_score = score;
                        best_p = p + start_p;
                        best_q = q + start_q;
                        best_a = a + start_a;
                        
                        imshow(I{index}*0.5 + tmp*0.5);
                        %best_s = s + start_s;
                    end
                end
            end
        end
    %end

end

