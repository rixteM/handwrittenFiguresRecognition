function vector_proba = prob_appartenance(number,vector_kppv,K)
  %clacul pour chaque classe de chiffre le vecteur de probabilité d'appartenance du chiffre testé à chaque classe
  vector_proba = [];  
  for i = 1:10
    nb_voisin = 0;
    for j = 1:size(vector_kppv)(2)
      if i-1 == vector_kppv(number,j)
        nb_voisin++;
      end       
    endfor 
    p2 = nb_voisin/K; 
    vector_proba = [vector_proba, p2];
  endfor
  return;
endfunction