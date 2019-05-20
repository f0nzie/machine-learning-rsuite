data {
  int<lower=1> N;
  int<lower=1> K;
  vector[N] y;
  matrix[N, K] X;
}
parameters {
  real alpha;
  vector[K] beta;
  real<lower=0> sigma;
}
model {
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);
  sigma ~ cauchy(0, 2.5);
  y ~ normal(alpha + X * beta, sigma);
}

