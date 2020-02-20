% computes (p,q) = argmin IM(I(x,y), Y(x+p, y+q))
function [best_p, best_q, best_a, best_s] = best_translation(I, Y, range_p, range_q, start_p, start_q, type, depth, channel)
    best_p = 0;
    best_q = 0;
    best_score = 0;
%     tmp = translation(Y{1},start_p,start_q);
%     image = I{1}*0.5 + tmp*0.5;
%     name = strcat('data/steps_khan/',channel, int2str(depth), '.png');
%     imwrite(image, name);
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
                disp(score);
                best_score = score;
                best_p = p + start_p;
                best_q = q + start_q;
                imshow(I{index} * 0.5 + tmp*0.5,[]);
            end
        end
    end
    %tmp = translation(Y{1},best_p, best_q);
    %image = I{1}*0.5 + tmp*0.5;
    %name = strcat('data/steps_khan/',channel, int2str(depth), '_registered.png');
    %imwrite(image, name);
    best_a = 0.0;
    best_s=1.0;

end