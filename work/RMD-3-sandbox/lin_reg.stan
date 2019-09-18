data {
  int<lower=1> N;
  vector[N] y;
  vector[N] x;
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
model {
  alpha ~ normal(0, 10);    // not in the manual
  beta ~ normal(0, 10);     // but you should do it
  sigma ~ cauchy(0, 2.5);
  y ~ normal(alpha + beta * x, sigma);
}



