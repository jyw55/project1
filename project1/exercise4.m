clear
% Assign value to parameters
n = 80;
T = 1.25*252;
nE = 20 * n;
ro = 0.03;
muc = 0.11^2;
sigmac = 0.001;
delta = 1 / n;
deltaE = 1 / nE;
steps = T*n;
stepsE = T*nE;
%Random standard normal
Zc = zeros(stepsE,1);
Zc(1) = normrnd(0,1);
% Stochastic variance(B)
C = zeros(stepsE,2);
C(1) = muc;
for j = 2:stepsE
    Zc(j) = normrnd(0,1);
    C(j,1) =  C(j-1,1) + ro*(muc-C(j-1,1))*deltaE + sqrt(C(j-1,1)*deltaE)*Zc(j);
    if C(j,1) < muc/2
        C(j,1) = muc/2;
    end
    C(j,2) = j/(80*20);
end
annC = C; 
annC(:,1)= C(:,1)* sqrt(252);
%Plot
plot(annC(:,2),annC(:,1))
title("Stochastic variance")
xlabel("Day")
ytickformat(gca, 'percentage')
set(gca,'XTick',[0:35:315]);

%The ultra high frequency log-prices(C)
Xt = zeros(stepsE,2);
Xt(1,1) = log(292.58);
Z = zeros(stepsE,1);
Z(1) = normrnd(0,1);
for j = 2:stepsE
    Z(j) = normrnd(0,1);
    Xt(j,1) =  Xt(j-1,1) + sqrt(C(j-1,1)*deltaE)*Z(j);
    Xt(j,2) = j/(80*20);
end 
price = Xt;
price(:,1) = exp(Xt(:,1)); 
%Plot
figure
plot(price(:,2),price(:,1))
title("Price simulation") 
ylabel("Price")
xlabel("Day")
set(gca,'XTick',[0:35:315]);

%return(D)
deltaXt = zeros(stepsE,2);
for i = 2:stepsE
   deltaXt(i,1) =  Xt(i,1)- Xt(i-1,1);
   deltaXt(i,2) = i/(80*20);
end
figure
plot(deltaXt(:,2),deltaXt(:,1))
title("Return simulation") 
ylabel("Return")
xlabel("Day")
ytickformat(gca, 'percentage')
set(gca,'XTick',[0:35:315]);

%the log-returns for coarser frequency(E)
X = zeros(steps,2);
for i = 1:steps
   X(i,1) = Xt(i*nE/n); 
end

deltaX = zeros(steps,2);
for i = 2:steps
   deltaX(i,1) =  X(i,1)- X(i-1,1);
   deltaX(i,2) = i/80;
end
figure
plot(deltaX(:,2),deltaX(:,1))
title("Return simulation") 
ylabel("Return")
xlabel("Day")
ytickformat(gca, 'percentage')
set(gca,'XTick',[0:35:315]);