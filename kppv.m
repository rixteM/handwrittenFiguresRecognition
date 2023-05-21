function [vectorKPPV] = kppv(chiffre, K, vector_density_ref, vector_density_test)
  
  vector_dist = [];
  vectorKPPV = [];
  number = [];
  %Calcul de la distance du vecteur de densit� de l'image test�e avec tous les vecteurs de l'image de r�f�rence. 
  for nb = 1:20:size(vector_density_ref)(1)
    for j = nb:nb+19
    vector_dist = [vector_dist, pdist2(vector_density_test(chiffre,:),vector_density_ref(j,:))];
    number = [number, floor(nb/20)];
    endfor
  endfor
  %Cr�ation d'un tableau avec les distances sur la premi�re ligne et les chiffres qui correspondent � cette de l'image de r�f�rence en 2e ligne
  vector = [vector_dist; number]; 
  %Permet de trier le tableau dans l'ordre croissant des distances
  vector_dist_sort = sortrows(vector.',1).';
  %Permet de r�cup�rer que les K premi�res valeurs du tableau de vecteurKPPV
  vectorKPPV = vector_dist_sort(:,1:K);
  return;
end