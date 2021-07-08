clc;  clear all;close all;

%parameters setting

N = 4;  % number of ap
K = 20; % number of user
t = rand(100);
P = 1;      %transmit power
h =1;         %small-scale channel fading
alpha = 1; 
d_a        %distance-based large-scale channel fading
sigma = 1  %noise power
U = 5;
T = [2,3,4,5];






x_ap = rand(N,1);
y_ap = rand(N,1);
X_ap = [x_ap,y_ap];

%need to coordinate
x_ue = rand(K,1);
y_ue = rand(K,1);
X_ue = [x_ue,y_ue];

X_ap(1,1)
X_ap(1,2)
X_ap(2,1)
X_ap(2,2)


%distance
for n = 1:N
    for k = 1:K
        d(n,k) = sqrt(abs(X_ap(n,1)-X_ue(k,1))^2  + abs(X_ap(n,2)-X_ue(k,2))^2 );
        
        
    end;
end;




for n = 1:N
    for k = 1:K
        A = P(n,k)*h(n,k)*d_a(n,k)*phi(n,k);
        B = sum(  P(:,k)*h(:,k)*d_a(:,k) ) - P(n,k)*h(n,k)*d_a(n,k) + sigma^2;
        
        SINR(n,k,t) = A/B;
        
    end;
end;

