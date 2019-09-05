% after executing exercise1.m and exercise2.m
jprice = X; 
jprice(:,1)= exp(X(:,1)+J(:,1));
%Plot
plot(jprice(:,2),jprice(:,1))
title("Price simulation") 
ylabel("Price")
xlabel("Day")
set(gca,'XTick',[0:21:315]);
