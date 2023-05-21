function [tauxReconnaissances] = tauxReconnaissance(results)
  %Fonction qui va comparer la matrice de résultat d'une classification de l'image 
  %test.tiff avec une matrice représentant l'image de base.
  matParfaite = [0,0,0,0,0,0,0,0,0,0;
                 1,1,1,1,1,1,1,1,1,1;
                 2,2,2,2,2,2,2,2,2,2;
                 3,3,3,3,3,3,3,3,3,3;
                 4,4,4,4,4,4,4,4,4,4;
                 5,5,5,5,5,5,5,5,5,5;
                 6,6,6,6,6,6,6,6,6,6;
                 7,7,7,7,7,7,7,7,7,7;
                 8,8,8,8,8,8,8,8,8,8;
                 9,9,9,9,9,9,9,9,9,9];
 
 tauxReconnaissances = [];
 allNumbersRecognized = 0;
  for i = 1:10    
    numbersRecognized = 0;
    for j = 1:10
      if(isequal(matParfaite(i,j),results(i,j)))
        numbersRecognized++;
        allNumbersRecognized++;
      endif
    endfor
    tauxReconnaissances = [tauxReconnaissances numbersRecognized/10];
    %disp(["Taux de reconnaissance du chiffre ",int2str(i)," : ",int2str(numbersRecognized/10)]);
  endfor
  disp(["Taux reconnaissance : ",int2str(allNumbersRecognized),"%"]);
  %tauxReconnaissances = allNumbersRecognized/100;
  return
endfunction
