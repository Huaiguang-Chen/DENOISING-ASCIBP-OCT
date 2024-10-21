
function delta = I(X)
    [m, n] = size(X);
    delta = zeros(m, n);

    offsets = [0 1; -1 1; -1 0; -1 -1]; 
    numLevels = 16;

    glcm = graycomatrix(X, 'Offset', offsets, 'NumLevels', numLevels, 'Symmetric', true);
    stats = graycoprops(glcm, {'Contrast', 'Homogeneity'});

    average_contrast = mean(stats.Contrast);
    average_homogeneity = mean(stats.Homogeneity);

    if average_homogeneity > 0.5
        delta(:) = 0.01;
    else
        delta(:) = 0.1 * (1 - (average_contrast / max(stats.Contrast)));
    end
end


  
