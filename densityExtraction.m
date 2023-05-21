%retourne un vecteur caract�ristique de densit� de taille d = n * m
function [density_vector] = densityExtraction(rect,n,m,img)
  
  % R�partition uniform�ment les indices des colones et des lignes selon n et m rentr�s en param�tre
  columns = linspace(rect(1),rect(1)+rect(3),n+1);
  lines = linspace(rect(2),rect(2)+rect(4),m+1);
  % Obtention de la taille largeurs et longueurs des nouvelles zones pour le calcul de densit�
  N  = columns(2) - columns(1);  
  M = lines(2) - lines(1);
  
  %Calcul de la densit� de pixels noirs selon les zones definies pr�c�demment 
  density_vector = [];
  for i = rect(1):N:(rect(1)+rect(3)- N)
    for j = rect(2):M:(rect(2)+rect(4)- M)
      somme = 0;
      for x = i:i+N
        for y = j:j+M
           somme = somme + img(floor(y),floor(x));     
        endfor
      endfor   
      somme = somme./(N*M*255);  
      density_vector = [density_vector; somme]; 
    endfor
  endfor
  %disp(density_vector);
  return;
endfunction