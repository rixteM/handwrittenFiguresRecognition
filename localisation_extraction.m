function [rectangles] = localisation_extraction(img)
    
  dispImg = img; %Variable uniquement utilisée pour l'affichage
  img = ~img; %On inverse l'image pour faciliter la suite
  
  finalIndicesV = []; %Va contenir les coordonnées verticales (lignes) de chaque rectangle englobant
  finalIndicesH = []; %Va contenir les coordonnées horizontales (colonnes) de chaque rectangle englobant
  
  projecV = sum(img,2); %On fait un premier histogramme de projection verticale des pixels blancs
    
  for i = 1:size(projecV)(1)        
    lines(i) = ~(projecV(i) == 0);  %lines(i) va contenir 1 si il y a des pixels noirs, 0 sinon
  endfor
  d = diff(lines); %On fait une différence dans lines pour trouver les extrémités
    
  indicesV = find(abs(d)); %On cherche les indices de ces extrémités
  indicesV = reshape(indicesV, 2, length(indicesV)/2);  %On réarrange les indices de manière plus lisible
  indices = indicesV; %indices va contenir, pour chaque intervalle de ligne, toutes les intervalles de colonnes correspondantes
  
  %On prépare l'affichage du résultat final
  figure;
  imshow(dispImg);
  hold on;
  
  for i = 1:length(indicesV)
    
    %On récupère une sous-image correspondant à chaque intervalle, pour ensuite faire une projection horizontale de cette sous-image
    subImg = img(indicesV(1, i):indicesV(2, i),:); 
    projecH = sum(subImg,1);    
    
    %Même procédé que pour la projection verticale
    for j = 1:size(projecH)(2)
      columns(j) = ~(projecH(j) == 0);
    endfor
    
    d = diff(columns);
    indicesH = find(abs(d));  
    indicesH = reshape(indicesH, 2, length(indicesH)/2);
    
    for k = 1:length(indicesH)  
      
##    Affichage des intervalles de colonnes trouvées
##    line([indicesH(1, k), indicesH(1, k)], [indicesV(1, i), indicesV(2, i)], "color", "g");
##    line([indicesH(2, k), indicesH(2, k)], [indicesV(1, i), indicesV(2, i)], "color", "y");
            
      %On ajoute les colonnes trouvées
      indices(2+2*k-1,i) = indicesH(1, k); 
      indices(2+2*k,i) = indicesH(2, k);      
      finalIndicesH = [finalIndicesH, indicesH(1, k), indicesH(2, k)]; 
    endfor
    
  endfor
  
##  Affichage des intervalles de lignes trouvées
##  for i = 1:size(indicesV)(2)
##      line([1, size(img)(2)], [indicesV(1, i), indicesV(1, i)], "color", "b");
##      line([1, size(img)(2)], [indicesV(2, i), indicesV(2, i)], "color", "r");
##  endfor
  
  %RECADRAGE, Il faut recadrer les lignes pour chaque chiffre
  
  for i = 1:size(indices)(2) %On parcourt les indices des lignes
    for j = 3:2:size(indices)(1)  %On parcourt les indices des colonnes
      
      %On récupère une sous-image pour chaque chiffre et on refait une projection verticale, même processus
      subImg = zeros(size(img)(1),size(img)(2));
      subImg(indices(1, i):indices(2, i),indices(j, i):indices(j+1, i)) = img(indices(1, i):indices(2, i),indices(j, i):indices(j+1, i));    
      projecV = sum(subImg,2); 
            
      for k = 1:size(projecV)(1)
        lines(k) = ~(projecV(k) == 0);
      endfor
     
      d = diff(lines);
      newIndicesV = find(abs(d));                        
      finalIndicesV = [finalIndicesV newIndicesV(1) newIndicesV(2)];
##    Affichage des nouvelles lignes pour chaque chifre  
##    line([indices(j, i), indices(j+1, i)], [newIndicesV(1), newIndicesV(1)], "color", "b");
##    line([indices(j, i), indices(j+1, i)], [newIndicesV(2), newIndicesV(2)], "color", "r");    
    endfor
  endfor   
  
  %Variable de retour, contenant une ligne avec tous les indices des lignes
  %et une ligne avec tous les indices des colonnes
##  rectangles = [finalIndicesV;
##                finalIndicesH];

  rectangles = zeros(length(finalIndicesV)/2,4);
  for i = 1:length(rectangles)
    rectangles(i,1) =  finalIndicesH(2*i-1);
    rectangles(i,2) =  finalIndicesV(2*i-1);
    rectangles(i,3) =  finalIndicesH(2*i)-finalIndicesH(2*i-1);
    rectangles(i,4) =  finalIndicesV(2*i)-finalIndicesV(2*i-1);
    rectangle('Position', rectangles(i,:), 'EdgeColor',rand(3,1), 'LineWidth',2);
  endfor
    
  %Affichage des rectangles englobants  
##  for i = 1:2:length(rectangles)
##    rectangle('Position',[rectangles(2,i) rectangles(1,i+1) rectangles(2,i+1)-rectangles(2,i) rectangles(1,i)-rectangles(1,i+1)], 'EdgeColor',rand(3,1), 'LineWidth',3);
##  endfor
  
  return;  
end