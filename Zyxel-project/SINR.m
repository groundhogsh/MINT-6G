%distance
function S = SINR(N, n , k,t_start, t_now,ap, sta, P , h , alpha, sigma ,action )
    
   
    

   tou = t_now - t_start + 1;
    

    %A = P(n,k,tou) * h(n,k,tou) * d(n,k,tou,ap,sta)^(-1*alpha) *phi;
    %B = sum(  P(:,k,tou) * h(:,k,tou) * d(:,k,tou,ap,sta)^(-1*alpha) ) - P(n,k,tou)*h(n,k,tou)*d(n,k,tou,ap,sta)^(-1*alpha) + sigma^2;
    
    A = P * h * d(n,k,t_now,ap,sta)^(-1*alpha) *phi(N , n,k,t_start, t_now,ap,sta ,action);
    B = 0; 
    for n_t = 1:N 
        if n_t ~= n
            B = B +  P * h * d(n_t,k,t_now,ap,sta)^(-1*alpha);
        end;
    end;    
    B  =  B  + sigma^2;
    
    
    S = A/B;
    	
    
