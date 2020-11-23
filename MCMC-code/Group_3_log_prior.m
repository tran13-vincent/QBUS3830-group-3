function val = Group_3_log_prior(theta_tilde)
    % Log prior function for the parameters of the reparameterised
    % GARCH model, derived in the solutions.
    % theta_tilde - row or column vector of length 3
    tt_1 = theta_tilde(1); % \tilde{theta}_1
    tt_2 = theta_tilde(2); % \tilde{theta}_2
    val = -log(2*pi) - ((tt_1 - 8)^2+(tt_2 + 2)^2)/2;
end