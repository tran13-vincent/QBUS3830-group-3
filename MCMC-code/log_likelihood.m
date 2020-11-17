function val = log_likelihood(theta_tilde,return_data)
    % Log likelihood function for the paramters of the reparameterised
    % GARCH model, derived in the solutions.
    % theta_tilde - row or column vector of length 3
    % return_data - y_t's as defined in the solutions; column vector
    
    tt_1 = theta_tilde(1); % \tilde{theta}_1
    tt_2 = theta_tilde(2); % \tilde{theta}_2
    tt_3 = theta_tilde(3); % \tilde{theta}_3
    
    alpha = (exp(tt_1)/(exp(tt_1) + 1))*(exp(tt_2)/(exp(tt_2) + 1));
    beta = (exp(tt_1)/(exp(tt_1) + 1))*(1/(exp(tt_2) + 1));
    w = exp(tt_3);
    
    sigma_sq_values = zeros(size(return_data,1),1);
    sigma_sq_values(1) = var(return_data);
    
    for t = 2:size(sigma_sq_values,1)
        sigma_sq_values(t) = w + alpha*(return_data(t - 1))^2 + ...
                             beta*sigma_sq_values(t - 1);
    end
    
    val = (-1/2)*sum(log(2*pi) + log(sigma_sq_values) + (return_data.^2)./sigma_sq_values);
    
end