%throughput at time tou
function throu = R( N ,K , t_start, t_now ,ap, sta, P , h , alpha, sigma ,action )
    throu = 0;
    for nn = 1:N
        for kk = 1:K

            A = log2(1 + SINR( N ,nn ,kk, t_start, t_now ,ap, sta, P , h , alpha, sigma  ,action));
            B = 0;
            for k_t = 1:K
                B = B + phi(N , nn ,k_t,t_start, t_now,ap,sta,action) ;
            end;
            if B ~= 0 
                throu = throu + A/B;
            end;

        end;
    end;
