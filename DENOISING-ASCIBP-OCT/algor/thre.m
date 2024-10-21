function y = thre(x, tau1)

    refa1 = 0.05;
    refa2 = 0.1;
    abs_x = abs(x); 
    y = zeros(size(x));
    
    total_energy = sum(abs_x.^2);
    cumulative_energy = cumsum(abs_x.^2) / total_energy;
    
    first_segment = find(cumulative_energy >= 0.9, 1, 'first');
   
    mean_val = mean(abs_x);
    std_val = std(abs_x);
    second_segment = find(abs_x > mean_val + std_val, 1, 'last');
    
    for i = 1:numel(x)
        if i <= first_segment
            y(i) = x(i) - (sign(x(i)) * tau1 * (refa1 + 1) * (refa1 - exp(-refa2 * (abs_x(i) - tau1)/tau1)))/(refa1- 1) * (refa1 + exp(-refa2 * (abs_x(i) - tau1)/tau1));
        elseif i > first_segment && i <= second_segment
            y(i) = x(i) - (sign(x(i)) * tau1 * (refa1 - exp(-refa2 * (abs_x(i) - tau1)/tau1)))/(refa1 + exp(-refa2 * (abs_x(i) - tau1)/tau1));
        else
            y(i) = 0;
        end
    end
end