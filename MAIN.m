clear all;
close all;
pkg load statistics;
pkg load image;
pkg load matgeom;

imgApp = imread("app.tif");
imgTest = imread("test.tif");

%LOCALISATION/EXTRACTION
%On extrait les rectangles des chiffres de l'image app.tif et test.tif qui vont nous servir à l'apprentissage des classifieurs.
rectApp = localisation_extraction(imgApp);
rectTest = localisation_extraction(imgTest);



##taux = []
##[nomFichier1,tauxReconnaissance] = classifieur_profils(10,rectApp,rectTest,imgApp,imgTest);
##for(i = 1:10)
##    taux(i) = tauxReconnaissance(i)
##endfor
##
##disp(taux);
##figure;
##labels = ["0"; "1"; "2"; "3" ; "4" ; "5" ; "6" ; "7" ; "8" ; "9"];
##bar(taux);
##set(gca,"xticklabel",labels);
##xlabel("Classe");
##ylabel("Taux de reconnaissance");
##title("Taux de reconnaissance classifieur profils (d=10)");
##

taux = []
somme_taux = [];
somme_taux_temp = [];
for i = 1:10
  tauxReconnaissance = 0;
  for j = 3:10
  [nomFichier1,tauxReconnaissance] = classifieur_densite(j,j,rectApp,rectTest,imgApp,imgTest,i);
  taux(j-2) = tauxReconnaissance
endfor
  somme_taux = [somme_taux; taux]
endfor
disp(somme_taux);

figure;
labels = ["1"; "2"; "3" ; "4" ; "5" ; "6" ; "7" ; "8" ; "9";"10"];
bar(somme_taux);
legend('n = m = 3', 'n = m = 4', 'n = m = 5', 'n = m = 6', 'n = m = 7', 'n = m = 8', 'n = m = 9', 'n = m = 10','Location', 'southeast');
set(gca,"xticklabel",labels);
xlabel("K plus proches voisins");
ylabel("Taux de reconnaissance");
title("Taux de reconnaissance classifieur densité en fonction de n, m  et K ");

##taux = [];
##K = [];
##for i = 4:10
##  [nomFichier1,tauxReconnaissance] = classifieur_densite(i,i,rectApp,rectTest,imgApp,imgTest,i);
##  taux = [taux, tauxReconnaissance];
##  K = [K, i];
##endfor
##disp(taux);
##disp(K);
##figure;
##plot(K,taux);
##xlabel("m = n");
##ylabel("Taux de reconnaissance");
##title("Taux de reconnaissance classifieur densité en focntion du zoning n * m");

%Classification de test.tif avec la méthode profils + classifieur par distance euclidienne minimum.
[nomFichier1,tauxReconnaissanceProfils] = classifieur_profils(180,rectApp,rectTest,imgApp,imgTest);

%Classification de test.tif avec la méthode densités + KPPV.
[nomFichier2,tauxReconnaissanceDensite] = classifieur_densite(6,6,rectApp,rectTest,imgApp,imgTest,10);


%COMBINAISON DES CLASSIFIEURS

%METHODE SOMME
tauxReconnaissanceSum = combinaison_classifieurs(nomFichier1,nomFichier2,"SUM");

%METHODE PRODUIT
tauxReconnaissanceProd = combinaison_classifieurs(nomFichier1,nomFichier2,"PROD");


%Affichage résultats par chiffre
figure;
y = []
for i = 1:10
  y(1,i) = tauxReconnaissanceDensite(i);
  y(2,i) = tauxReconnaissanceProfils(i);
  y(3,i) = tauxReconnaissanceSum(i);
  y(4,i) = tauxReconnaissanceProd(i);
endfor

bar(y);
set(gca,"xticklabel",{'Densité/KPPV (n=m=6 et K=2)','Profils/Centres (d=180)','Sum','Prod'});
title("Reconnaissance par chiffre des classifieurs et de leurs combinaisons ");

##Affichage des résultats globeaux
##figure;
##y = []
##y(1) = tauxReconnaissanceDensite;
##y(2) = tauxReconnaissanceProfils;
##y(3) = tauxReconnaissanceSum;
##y(4) = tauxReconnaissanceProd;
##bar(y);
##set(gca,"xticklabel",{'Densité/KPPV (n=m=6 et K=2)','Profils/Centres (d=180)','Sum','Prod'});