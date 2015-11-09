

clear all;

linf = 1;
lb = 0.1;

g = 1;
f = 1;

rB = g/3 /(f + g);

accprop = [0, 0.25, 0.5, 0.75, 0.95]; % acceleration proportion
sM = (accprop * linf + (1 - accprop) * lb)/ lb;

taub = 10;
tau = 0:0.1:40;

for j = 1: length(sM)
  lj = sM(j) * lb;
  % rj = rB * (f - lb)/ lb;
  rj = rB * (linf - lj)/ lj;
  tauj = -1/ rB * log((linf - lj)/(linf - lb));

  for i = 1:length(tau)
    if tau(i) < tauj + taub
      l(i, j) = lj * exp(rj * (tau(i) - taub - tauj));
      if l(i, j) < lb
        l(i, j) = lb;
      end
    else
      l(i, j) = linf - (linf - lb) * exp (- rB * (tau(i) - taub));
    end
  end
end

plot(tau, l)