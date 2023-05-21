function [profils] = profils(x1,y1,x2,y2,img,d)         
    profils = [];
    distancesGauche = [];
    distancesDroite = [];    
    subImg = img(y1:y2,x1:x2); 
        
    indices = linspace(2,y2-y1,d/2);%2 est le début de l'intervalle, y2-y1 est la hauteur du chiffre et la fin de l'intervalle, d/2 le nombre d'indices
           
    for i = 1:d/2         
      distanceGauche = find(~subImg(floor(indices(i)),:),1);      
      distancesGauche = [distancesGauche distanceGauche];
      distanceDroite = size(subImg)(2)-find(~subImg(floor(indices(i)),:),1,'last');
      distancesDroite = [distancesDroite distanceDroite];
    endfor
    
    profils = [distancesGauche distancesDroite];    
    return;
end