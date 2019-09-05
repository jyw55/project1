clear
% Assign value to parameters
n = 80;
T = 1.25*252;
mu = 0.0003782;
sigma = 0.011;
delta = 1 / n;
steps = T*n;
%log-price matrix. The second column shows the date and only used for graphing.
X = zeros(steps,2);
%Random standard normal
Z = zeros(steps,1);
Z(1) = normrnd(0,1);

X(1,1) = log(292.58);
X(1,2) = 0;

%Generate price sequense
for i = 2:steps
    Z(i) = normrnd(0,1);
    X(i,1) = X(i-1,1) + mu*delta +  sqrt(sigma)*delta * Z(i);
    X(i,2) = i/80;
end
price = X;
price(:,1) = exp(X(:,1)); 
%Plot
plot(price(:,2),price(:,1))
title("Price simulation") 
ylabel("Price")
xlabel("Day")
set(gca,'XTick',[0:35:315]);

