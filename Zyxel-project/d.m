%distance
function distance = d(n,k,tou,ap,sta)
    
    X = [ap(n).x , ap(n).y ; sta(k,tou).x , sta(k,tou).y];
    distance = pdist(X,'euclidean');	
    
    
