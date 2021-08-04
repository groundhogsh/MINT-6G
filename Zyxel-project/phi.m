% phi --- 用來判斷是不是連到最近的ap
function P = phi(N , n , k,  t_start, t_now  , ap,sta ,action) 
   % T = 2;    % beacon interval
    
   tou = t_now - t_start + 1;
   
    while mod(tou-1, action)~=0
        t_now = t_now-1;
        tou = tou-1;
    end;
    
    P = 0;  
    for n_t = 1:N
        vec(n_t) =  d(n_t,k,t_now,ap,sta);
    end;

    [C,I] = min( vec );

    if I == n
        P = 1;
    end;
    
    
    
    
    
    
    

