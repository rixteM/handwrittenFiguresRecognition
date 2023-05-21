function [tauxReconnaissance] = combinaison_classifieurs(nomFichier1,nomFichier2,prodOrSum)
  %Fonction permettant de combiner deux classifieurs � partir des fichiers contenants leurs vecteurs de probabilit�s.
  %prodOrSum permet de choisir si l'on veut combiner en utilisant la m�thode Somme ou Produit.
  
  %On charge les vecteurs de probabilit�s � partir des noms de fichiers en param�tre.
  load(nomFichier1);
  load(nomFichier2);
  
  %COMBINAISON PAR SOMME
  if isequal(prodOrSum,"SUM")
    vecteursProbasFinal = [];
    for i = 1:size(vecteursProbas)(1)
      for j = 1:size(vecteursProbas)(2)
        %Pour chaque probabilit� d'un chiffre d'appartenir � chaque classe, 
        %on additionne les probabilit�s que 
        %ce chiffre appartienne � cette classe de chaque classifieur.
        probaFinale = vecteursProbas(i,j)+vecteursDensite(i,j);    
        %On fait ensuite une addition similaire, pour chaque classe, 
        %que l'on rassemble en une somme.
        sommeProbas = 0;
        for k = 1:size(vecteursProbas)(1)
          sommeProbas += vecteursProbas(k,j)+vecteursDensite(k,j);
        endfor
        %On divise ensuite la proba additionn�e d'appartenance du chiffre 
        %� la classe et les probas 
        %additionn�es d'appartenance du chiffre � toutes les classes.
        probaFinale = probaFinale/sommeProbas;
        %On ajoute le r�sultat au vecteur final de probabilit�s
        vecteursProbasFinal(i,j) = probaFinale;
      endfor
    endfor

    %Affichage des r�sultats sous la forme d'une matrice repr�sentant l'image test.tif.
    results = [];
    for i = 1:size(vecteursProbasFinal)(1)           
      results = [results find(vecteursProbasFinal(i,:) == max(vecteursProbasFinal(i,:)),1)-1];
    endfor

    results = reshape(results, 10, length(results)/10);
    results = rot90(results,-1);

    disp('COMBINAISON SOMME');
    disp(results);
    tauxReconnaissance = tauxReconnaissance(results);
  endif
  
  %COMBINAISON PAR PRODUIT
  %M�me processus que pour Somme, sauf que l'on fait un produit entre les probabilit�s des deux classes.
  if isequal(prodOrSum,"PROD")
    vecteursProbasFinal = [];
    for i = 1:size(vecteursProbas)(1)
      for j = 1:size(vecteursProbas)(2)
        probaFinale = vecteursProbas(i,j)*vecteursDensite(i,j);
        sommeProbas = 0;
        for k = 1:size(vecteursProbas)(1)
          sommeProbas += vecteursProbas(k,j)*vecteursDensite(k,j);
        endfor
        probaFinale = probaFinale/sommeProbas;
        vecteursProbasFinal(i,j) = probaFinale;
      endfor
    endfor


    results = [];
    for i = 1:size(vecteursProbasFinal)(1)           
      results = [results find(vecteursProbasFinal(i,:) == max(vecteursProbasFinal(i,:)),1)-1];
    endfor

    results = reshape(results, 10, length(results)/10);
    results = rot90(results,-1);

    disp('COMBINAISON PRODUIT');
    disp(results);
    tauxReconnaissance = tauxReconnaissance(results);
  endif
  return
endfunction
