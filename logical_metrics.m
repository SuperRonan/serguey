function [intersection,union, precision, recall, fmesure] = image_intersection(I,J)
    
    intersection = sum(sum(I&J));
    union = sum(sum(I|J));
    nb_pixels_I = sum(sum(I));
    precision = intersection/union;
    recall = intersection/nb_pixels_I;
    fmesure = (precision * recall) / (precision + recall);
end
