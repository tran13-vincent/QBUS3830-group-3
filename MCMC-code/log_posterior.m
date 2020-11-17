function val = log_posterior(theta_tilde,return_data)
    % Log posterior function for the parameters of the reparameterised
    % GARCH model, derived in the solutions.
    % theta_tilde - row or column vector of length 3
    % return_data - y_t's as defined in the solutions; column vector
    val = log_prior(theta_tilde) + log_likelihood(theta_tilde,return_data);
end