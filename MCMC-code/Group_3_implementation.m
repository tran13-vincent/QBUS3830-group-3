
% ========== MCMC implementation for project ========== %

% Importing the stock prices
prices = xlsread("Price History_Commonwealth bank.xlsx", "Sheet 1", "B12:B2210");

% Converting the prices to returns
prices_shifted = [NaN;prices(1:end-1)];
returns_full = log(prices./prices_shifted);
returns = returns_full(2:end);

% Setting up Metropolis-Hastings
rng(3830);
Niter = 100000; % Number of iterations
Nburnin = 1000; % Number of burnin iterations out of the total
markov_chain = zeros(Niter,3); % Matrix to store results
TT_0 = randn(1,3); % \tilde{\theta}_0 (vector); random starting value
markov_chain(1,:) = TT_0; % Store the starting value
Sigma = 0.1*eye(3); % Covariance matrix of the algorithm

% Metropolis-Hastings random walk
n = 1;
while n < Niter
    epsilon = mvnrnd(zeros(3,1),Sigma);
    proposal = markov_chain(n,:)' + epsilon';
    accept_prob = min(exp(Group_3_log_posterior(proposal,returns) - ...
                          Group_3_log_posterior(markov_chain(n,:)',returns)),1);
    u = rand;
    if u < accept_prob
        markov_chain(n + 1,:) = proposal';
    else
        markov_chain(n + 1,:) = markov_chain(n,:);
    end
    if mod(n + 1,5000) == 0
        fprintf("Iteration %0.0f of %0.0f completed.\n",n + 1,Niter);
    end
    n = n + 1;
end

tt_1_values = markov_chain(:,1); % \tilde{\theta}_1
tt_2_values = markov_chain(:,2); % \tilde{\theta}_2
tt_3_values = markov_chain(:,3); % \tilde{\theta}_3

alpha_values = (exp(tt_1_values)./(exp(tt_1_values) + 1)).* ...
               (exp(tt_2_values)./(exp(tt_2_values) + 1));
           
beta_values = (exp(tt_1_values)./(exp(tt_1_values) + 1)).* ...
              ((1)./(exp(tt_2_values) + 1));
          
w_values = exp(tt_3_values);

% Visualising the trace plots for each component (transformed)

figure(1);

subplot(3,1,1);
plot(tt_1_values((Nburnin + 1):end), "k");
title("Trace plot for \theta_1 tilde","FontSize",20);
xlabel("Step number after burn-in","FontSize",20);
ylabel("\theta_1 tilde value","FontSize",20);
ax = gca;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;

subplot(3,1,2);
plot(tt_2_values((Nburnin + 1):end), "k");
title("Trace plot for \theta_2 tilde","FontSize",20);
xlabel("Step number after burn-in","FontSize",20);
ylabel("\theta_2 tilde value","FontSize",20);
ax = gca;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;

subplot(3,1,3);
plot(tt_3_values((Nburnin + 1):end), "k");
title("Trace plot for \theta_3 tilde","FontSize",20);
xlabel("Step number after burn-in","FontSize",20);
ylabel("\theta_3 tilde value","FontSize",20);
ax = gca;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;

% Visualising the trace plots for each component (original)

figure(2);

subplot(3,1,1);
plot(alpha_values((Nburnin + 1):end), "k");
title("Trace plot for \alpha","FontSize",20);
xlabel("Step number after burn-in","FontSize",20);
ylabel("\alpha value","FontSize",20);
ax = gca;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;

subplot(3,1,2);
plot(beta_values((Nburnin + 1):end), "k");
title("Trace plot for \beta","FontSize",20);
xlabel("Step number after burn-in","FontSize",20);
ylabel("\beta value","FontSize",20);
ax = gca;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;

subplot(3,1,3);
plot(w_values((Nburnin + 1):end), "k");
title("Trace plot for w","FontSize",20);
xlabel("Step number after burn-in","FontSize",20);
ylabel("w value","FontSize",20);
ax = gca;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;

% Estimating the posterior mean and posterior standard deviation for
% each component (transformed)

tt_1_estimate = mean(tt_1_values((Nburnin + 1):end));
tt_2_estimate = mean(tt_2_values((Nburnin + 1):end));
tt_3_estimate = mean(tt_3_values((Nburnin + 1):end));

fprintf("\nPosterior mean and SD estimates for theta_tilde_1: (%.4f,%.4f)\n",...
        tt_1_estimate,...
        std(tt_1_values((Nburnin + 1):end)));
fprintf("Posterior mean and SD estimates for theta_tilde_2: (%.4f,%.4f)\n",...
        tt_2_estimate,...
        std(tt_2_values((Nburnin + 1):end)));
fprintf("Posterior mean and SD estimates for theta_tilde_3: (%.4f,%.4f)\n",...
        tt_3_estimate,...
        std(tt_3_values((Nburnin + 1):end)));

% Estimating the posterior mean and posterior standard deviation for
% each component (original)

alpha_estimate = mean(alpha_values((Nburnin + 1):end));
beta_estimate = mean(beta_values((Nburnin + 1):end));
w_estimate = mean(w_values((Nburnin + 1):end));
    
fprintf("\nPosterior mean and SD estimates for alpha: (%.4f,%.4f)\n",...
        alpha_estimate,...
        std(alpha_values((Nburnin + 1):end)));
fprintf("Posterior mean and SD estimates for beta: (%.4f,%.4f)\n",...
        beta_estimate,...
        std(beta_values((Nburnin + 1):end)));
fprintf("Posterior mean and SD estimates for w: (%.9f,%.10f)\n\n",...
        w_estimate,...
        std(w_values((Nburnin + 1):end)));
    
% Estimating the volatility on the 12th of September

estimated_sigma_sq_values = zeros(length(returns),1);
estimated_sigma_sq_values(1) = var(returns);

for t = 2:length(estimated_sigma_sq_values)
        estimated_sigma_sq_values(t) = w_estimate + alpha_estimate*(returns(t - 1))^2 + ...
                                       beta_estimate*estimated_sigma_sq_values(t - 1);
end

fprintf("Estimate for the volatility on the 12th of September is: %.7f\n", ...
        w_estimate + alpha_estimate*returns(end)^2 + beta_estimate*estimated_sigma_sq_values(end));
