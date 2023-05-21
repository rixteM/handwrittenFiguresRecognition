function [nomFichier,tauxReconnaissance] = classifieur_profils(d,rectApp,rectTest,imgApp,imgTest)    

  %APPRENTISSAGE
  %On crée une matrice de vecteurs caractéristiques contenant, pour chaque chiffre, les distances de son profil gauche et droit .
  vecteursCarac = [];
  for i = 1:size(rectApp)(1)
    vecteursCarac = [vecteursCarac ; profils(rectApp(i,1),rectApp(i,2),rectApp(i,3)+rectApp(i,1),rectApp(i,4)+rectApp(i,2),imgApp,d)];
  endfor
  
  %Pour chaque classe, on calcule son centre (moyenne entre les vecteurs caractéristiques sur les 20 chiffres de chaque classe).
  %On les stocke ensuite dans un vecteur.
  centresClassifieur = [];
  for i = 1:20:size(vecteursCarac)(1)
    centre = mean(vecteursCarac(i:i+20-1,:)); 
    for j = 1:length(centre)
      centresClassifieur(floor((i+20)/20),j) = centre(j);
    endfor
  endfor

  %DECISION
  %On crée une matrice de vecteurs caractéristiques contenant, pour chaque chiffre, les distances de son profil gauche et droit.
  vecteursCarac = [];
  for i = 1:size(rectTest)(1)
    profil = profils(rectTest(i,1),rectTest(i,2),rectTest(i,3)+rectTest(i,1),rectTest(i,4)+rectTest(i,2),imgTest,d);
    vecteursCarac = [vecteursCarac ; profil];
  endfor
  
  %Pour chaque chiffre de test.tif, on compare la distance de son vecteur caractéritique au centre classifieur de chaque classe.
  %On obtient une matrice où chaque ligne contient un vecteur de probabilité pour un chiffre d'appartenir à telle classe.
  vecteursProbas = [];
  for i = 1:size(vecteursCarac)(1)
    for j = 1:size(centresClassifieur)(1)
      %On calcule la distance euclidienne entre le vecteur caractéristique du chiffre et de la classe correspondante.
      numerateur = exp(-pdist2(vecteursCarac(i,:),centresClassifieur(j,:)));      
      %numerateur = exp(-distancePoints(vecteursCarac(i,:),centresClassifieur(j,:),1));
      denominateur = 0;
      %On fait ensuite une somme des distances du vecteur caractéristique du chiffre à toutes les classes.
      for k = 1:size(centresClassifieur)(1)
        denominateur += exp(-pdist2(vecteursCarac(i,:),centresClassifieur(k,:)));
        %denominateur += exp(-distancePoints(vecteursCarac(i,:),centresClassifieur(k,:),1));
      endfor
      %Que l'on divise à la distance entre le chiffre et la classe concernée.
      proba = numerateur/denominateur;
      vecteursProbas(i,j) = proba;
    endfor
  endfor
  
  disp(vecteursProbas);
  
  %On sauvegarde les vecteurs de probabilités dans un fichier.
  save vecteursProfils.mat vecteursProbas;
  nomFichier = "vecteursProfils.mat";
  
  %On affiche ici les résultats de la classification sous la forme d'une matrice imitant l'image test.tif.
  results = [];
  for i = 1:size(vecteursProbas)(1)           
    results = [results find(vecteursProbas(i,:) == max(vecteursProbas(i,:)),1)-1];
  endfor

  results = reshape(results, 10, length(results)/10);
  results = rot90(results,-1);

  disp('CLASSIFIEUR PROFILS');
  disp(results);
  tauxReconnaissance = tauxReconnaissance(results);
  return
end