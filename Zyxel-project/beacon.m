clc;  clear all;close all;

%parameters setting

N = 4;  % number of ap
K = 5; % number of user
tou_interval = 1;  % (s) 每更新一次座標的時間 0.01
T_MAX  = 1000;
direction = 0;  %移動方向
radius = 0.1;     %每次移動的距離
P = 1;          %transmit power
h =1;           %small-scale channel fading
alpha = 2;      %d^alpha: distance-based large-scale channel fading
sigma = 1 ;     %noise power
UU = 5;          %over past U time slots 
%T = [2,3,4,5];  % beacon interval (how long to adjust nearest-association policy)




%---------setting----------


% set  ap  coordinate  in  center of space
ap(1).x = 1; ap(1).y = 1;
ap(2).x = 1; ap(2).y = -1;    
ap(3).x = -1;ap(3).y = -1;    
ap(4).x = -1;ap(4).y = 1;


% set  ap  coordinate  random in [-2 2]
% for i=1:N
%     ap(i).x = (rand()*2-1) * 2;
%     ap(i).y = (rand()*2-1) * 2;
% end;
% 


%ap 位置
figure(1);
for ap_i = 1:N  
    ap_x(ap_i) = ap(ap_i).x; 
    ap_y(ap_i) = ap(ap_i).y;
end;
plot(ap_x,ap_y,'*','LineStyle','none');
axis([-2  2 -2  2 ]);
title('AP location');


% set  sta coordinate  移動地方還要做調整 
for i=1:K
    sta(i,1).x = (rand()*2-1) * 2;
    sta(i,1).y = (rand()*2-1) * 2;
    
    %time interval tou (need to be 0.01)
    for tou = 1:tou_interval:T_MAX
        
        if mod(tou, 3)==0
            radius = 0.5;
        else
            radius = 0.01;
        end;
        vec = [radius , 0 ];
        angle = randi([-314,314],1,1);
        angle = angle/100;
        transitionMaxis = [cos(angle) sin(angle);-sin(angle) cos(angle)]; %坐标转换矩阵
        vec_t  = vec * transitionMaxis; %向量旋转angle角度
        sta(i,tou+1).x = vec_t(1)+sta(i,tou).x; 
        sta(i,tou+1).y = vec_t(2)+sta(i,tou).y;
        if abs(sta(i,tou+1).x) > 2
            sta(i,tou+1).x = sta(i,tou+1).x - 2 * vec_t(1);
        end;
        
        if abs(sta(i,tou+1).y) > 2
            sta(i,tou+1).y = sta(i,tou+1).y - 2 * vec_t(2);
        end;
        
    end;
end;





% user移動軌跡
figure(2);
for tou = 1:T_MAX  
    x(tou) = sta(1,tou).x; 
    y(tou) = sta(1,tou).y;
end;
plot(x,y);
axis([-2  2 -2 2 ]);
title('User1 moving path');
%---------test----------
% ans0 sta-ap連接狀況
% ans1 sta-ap 距離
% ans2 sta-ap SINR
% ans3 每個tou 的throughput

% for tou = 1:tou_interval:T_MAX
%     for n = 1:N
%         for k = 1:K
%             %ans0(n,k,tou) = phi(N , n,k,tou,ap,sta);
%             %ans(n,k,tou) = d(n,k,tou,ap,sta);
%             %ans2(n,k,tou) = SINR( N  , n ,k, tou ,ap, sta, P , h , alpha, sigma  ) ;
%             
%         end;
%     end;
%     ans3(tou) = R( N ,K , tou ,ap, sta, P , h , alpha, sigma ,a) ;
% end;


% ---------------q-learning-------------------
%(epsilon, alpha , gamma ) = (0.8 , 0.5 , 0.9);
%initial  
% close all;

for learn_rat = 0.6:0.05:0.7
    
    %action = [1,2,3,4,5];
    %action = [2,3,4,5,6];  
    action = [3,4,5,6,7];

    epsilon0 = 0.1 ;   %prob of chose beacon interval T= [2,3,4,5]
    %learn_rat = 0.5;   % alpha
    gamma = 0.8;      
    t= 1;
    for i=1:max(action)
        Q(i) = 0;
    end;
    epsilon = epsilon0;
    u = action(1);
    a = action(1);
    % u 每次learn 內的時間 會從1開始 和 T 相關
    % t 實際跑的時間 一直數下去 time slot 記數 U(t) 相關
    % a 這次learn 要執行的action 可能是2,3,4,5
    iteration = 1;
    count_a = 0;
    count_q = 0;
    while t < T_MAX+1   %實際跑的時間

        if  u == a 
            %執行qlearn 找新的action
            t_start = t;
            throughput(t) = R( N ,K , t_start, t ,ap, sta, P , h , alpha, sigma ,a) ;
            if (rand() < epsilon) | (t == 1)
                a = action(randperm(numel(action),1));       %隨機選interval
                count_a = count_a + 1;
            else
                [argvalue, a] = max( Q );                  % a = argmax O(a_k)
            end;
            U(iteration) = a;
            if t ==  1 % 只會跑進來一次interval (最一開始) 
                reward(iteration)  =  throughput(t) ;
            else    
                reward(iteration)  =  sum( throughput( t-U(iteration-1) + 1 : t ) ) / U(iteration-1);
            end;

            Q(a) = Q(a) + learn_rat * ( reward(iteration) + gamma * max(Q) - Q(a)  );

            
            
            
            total_SINR(iteration) = 0;
            for n_sinr = 1:N
                for k_sinr = 1:K
                    total_SINR(iteration) = total_SINR(iteration) + SINR( N  , n_sinr ,k_sinr, t_start, t ,ap, sta, P , h , alpha, sigma ,a ) ;      
                end;
            end;

            epsilon = epsilon0 / sqrt(iteration);
            iteration = iteration + 1;
            u = 1;
            count_q = count_q + 1;
        else
            % 算 throughput
            throughput(t) = R( N ,K , t_start, t ,ap, sta, P , h , alpha, sigma ,a) ;
            u = u+1;

        end;


        %紀錄位置
        for n_phi = 1:N
            for k_phi = 1:K
                ans0(n_phi,k_phi,t) = phi(N , n_phi,k_phi,t_start, t,ap,sta, a );    
            end;
        end;



        t = t + 1;
    end


    for i = 1:max(action)    
        total(i) = length(find(U == i));   
    end;


    %[M,record(r)] = max(total);
    figure; 
    titleStr=sprintf('esp = %f alpha = %f gamma = %f',epsilon0,learn_rat,gamma); 
    %axis([1  length(U)  ]);
    plot(U,'*','LineStyle','none');
    hold on
    plot(reward);
    legend('action','reward');title(titleStr);
    hold off


end;
% 
%figure(3);
%plot(record);

%---------draw-----------

% figure(1);
% % subplot(2,1,1);
% bar(action(:),total(action(:)));
% xlabel('a_k'), ylabel('times'),title("number of use a_k ");
% 
% 
% % x-axis會是iteration(n-th beacon)，y-axis會是 1. action 2. total SINR 3. Throughput (i.e., reward)
% figure(2); 
% %axis([1  length(U)  ]);
% %subplot(2,1,1);
% plot(U);
% hold on
% % plot(reward);
% plot(total_SINR);
% legend('action','total-SINR');
% hold off
% % subplot(2,1,2);
% 
% % %title('total-SINR');
% % 
% figure(3); 
% %axis([1  length(U)  ]);
% plot(U);
% hold on
% plot(reward);
% legend('action','reward');
% hold off

