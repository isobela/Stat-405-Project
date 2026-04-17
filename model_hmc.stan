
data {
  int<lower=1> I;
  int<lower=1> J;
  array[I,J] int<lower=0> y;
}
parameters {
  real mu;
  vector[I] alpha_raw;
  vector[J] beta_raw;
  real<lower=0> sigma_alpha;
  real<lower=0> sigma_beta;
}
transformed parameters {
  vector[I] alpha = sigma_alpha * alpha_raw;
  vector[J] beta = sigma_beta * beta_raw;
}
model {
  mu ~ normal(0,5);
  alpha_raw ~ normal(0,1);
  beta_raw ~ normal(0,1);
  sigma_alpha ~ normal(0,2);
  sigma_beta ~ normal(0,2);

  for(i in 1:I)
    for(j in 1:J)
      y[i,j] ~ poisson_log(mu + alpha[i] + beta[j]);
}
generated quantities {
  matrix[I,J] lambda;
  for(i in 1:I)
    for(j in 1:J)
      lambda[i,j] = exp(mu + alpha[i] + beta[j]);
}

