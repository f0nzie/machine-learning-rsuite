data {
  int N;
  vector[N] x;
  vector[N] y;
}
parameters {
  real alpha;
  real beta;
  real sigma;
}
model {
  y ~ normal(alpha + beta * x, sigma);
}
