% Assign value to parameters
n = 80;
T = 1.25*252;
sigma = 0.011;
lambda = 15/252;
sigmaj = 18*sigma*sqrt(1/n);
delta = 1 / n;
steps = T*n;
%Number of jumps
N = poissrnd(lambda*T);
%Sizes of jumps the timing of jumps
Y = zeros(N,1);
U = zeros(N,1);
for i = 1:N
    Y(i) = normrnd(0,sigmaj);
    U(i) = unifrnd(0,1);
end
%Compound Poisson process
J = zeros(steps,2);
for t = 1:steps
    for i = 1:N
    if  U(i)<= t/(steps)
      J(t,1) =  J(t,1) + Y(i,1);
    end
    end
    J(t,2) = t/80;
end
jump = J;
jump(:,1) = exp(J(:,1)); 
%Plot
plot(jump(:,2),jump(:,1))
title("Jump simulation") 
ylabel("Jump size")
xlabel("Day")
set(gca,'XTick',[0:21:315]);
txt = sprintf('N = %i', N);
text(315,max(jump(:,1)),txt)
