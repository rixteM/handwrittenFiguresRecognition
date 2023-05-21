function [vectorKPPV] = kppv(chiffre, K, vector_density_ref, vector_density_test)
  
  vector_dist = [];
  vectorKPPV = [];
  number = [];
  %Calcul de la distance du vecteur de densité de l'image testée avec tous les vecteurs de l'image de référence. 
  for nb = 1:20:size(vector_density_ref)(1)
    for j = nb:nb+19
    vector_dist = [vector_dist, pdist2(vector_density_test(chiffre,:),vector_density_ref(j,:))];
    number = [number, floor(nb/20)];
    endfor
  endfor
  %Création d'un tableau avec les distances sur la première ligne et les chiffres qui correspondent à cette de l'image de référence en 2e ligne
  vector = [vector_dist; number]; 
  %Permet de trier le tableau dans l'ordre croissant des distances
  vector_dist_sort = sortrows(vector.',1).';
  %Permet de récupérer que les K premières valeurs du tableau de vecteurKPPV
  vectorKPPV = vector_dist_sort(:,1:K);
  return;
end