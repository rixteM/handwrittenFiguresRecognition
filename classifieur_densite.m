function [nomFichier,tauxReconnaissance] = classifieur_densite(n,m,rectApp,rectTest,imgApp,imgTest,K)

    %invertion de l'image d'apprentissage
    imgApp = ~imgApp;
    
    %Création d'un tableau comprenant le vecteur de densité de tous les chiffres de l'image d'apprentissage
    vector_density_ref = [];
    vector_density_temp = [];
    for i = 1:length(rectApp)
       vector_density_temp = densityExtraction(rectApp(i,:),n,m,imgApp);
       for j = 1 : length(vector_density_temp)
         vector_density_ref(i,j) = vector_density_temp(j);
       endfor
    endfor
    
    %inverstion de l'image test
    imgTest = ~imgTest;

    %Création d'un tableau comprenant le vecteur de densité de tous les chiffres de l'image test
    vector_density_test = [];
    vector_density_temp = [];
    for i = 1:length(rectTest)
       vector_density_temp = densityExtraction(rectTest(i,:),n,m,imgTest);
       for j = 1 : length(vector_density_temp)
         vector_density_test(i,j) = vector_density_temp(j);
       endfor
    endfor
  
  %Création d'un tableau contenant les vecteurs KPPV et le chiffre qui leur correspond pour tous les chiffres de l'image test
  vector_kppv = [];
  for i = 1:size(vector_density_test)(1)
    vector_kppv_temp = kppv(i,K,vector_density_ref,vector_density_test);
    vector_kppv = [vector_kppv; vector_kppv_temp];
  endfor 

  %Calcul des vecteurs de probabilités pour tous les chiffres composants l'image test
  vecteursDensite = [];
  for i = 2:2:size(vector_kppv)(1)
    tab_vector_proba_temp = prob_appartenance(i,vector_kppv,n*m);
    vecteursDensite = [vecteursDensite; tab_vector_proba_temp];
  endfor 
  %Sauvegarde des vecteurs de propabilités de densité dans un fichier .mat pour faciliter son utilisation
  save vecteursDensite.mat vecteursDensite;
  nomFichier = "vecteursDensite.mat";
   
  %Afficher les résultats de la classification sous la forme d'une matrice imitant l'image test.tif. 
  results = [];
  for i = 1:size(vecteursDensite)(1)           
    results = [results find(vecteursDensite(i,:) == max(vecteursDensite(i,:)),1)-1];
  endfor

  results = reshape(results, 10, length(results)/10);
  results = rot90(results,-1);
  
  disp("CLASSIFIEUR DENSITE");
  disp(results);
  tauxReconnaissance = tauxReconnaissance(results);  
endfunction