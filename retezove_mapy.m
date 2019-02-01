% ur�en� po�tu t��d metodou retezove mapy
function [ output_args ] = retezove_mapy( data, t )
% data = mnozina obrazu
% t = konstanta ovliv�uj�c� prahovou hodnotu rozd�len� t��d
% vrac� [ po�et t��d ]

data_size = size(data);
mapa = zeros(data_size(1),3);
r = 1 + (data_size(1)-1)*rand(1); % nahodne cislo po��te�n�ho bodu
r = round(r);
mapa(1,1) = data(r,1);
mapa(1,2) = data(r,2);

% generov�n� matice vzd�lenost�
matice = zeros(data_size(1));
for i = 1:data_size(1)    
    for j = i + 1:data_size(1)
        matice(i,j) = sum((data(i,:)-data(j,:)).^2); %vzd�lenost dvou bod�
        matice(j,i) = matice(i,j); %matice je symetrick�
    end
end

matice(matice == 0 ) = NaN;
for k = 2:data_size(1)  
    % hled�n� minima
    %matice(matice == 0 ) = NaN; % zm�n� nulov� vzd�lenosti na NaN
    [M,I] = min(matice(r,:)); %M = hodnota, I = pozice
    %matice(isnan(matice)) = 0; % zm�n� NaN zp�t na nulov� vzd�lenosti

    mapa(k,1) = data(I,1);
    mapa(k,2) = data(I,2);
    mapa(k,3) = M;
   
    
    % redukce matice
    matice(:,r) = NaN;
    matice(r,:) = NaN;
    r = I;
end


%% test data
% data = [2 -3; 3 3; 2 2; -3 1; -1 0; -3 -2; 1 -2; 3 2];

%% vykreslen�
figure
plot(mapa(:,1),mapa(:,2))
title('Metoda �et�zov� mapy - mapa')

figure
plot(mapa(:,3))
title('Metoda �et�zov� mapy - pr�b�h tvorby vzd�lenostn� mapy')
xlabel('Index vzd�lenosti')
ylabel('Vzd�lenost mezi nejbli���mi body')

%% ur�en� po�tu t��d
prah = max(mapa(:,3)) / t;

tridy = 1;
for i = 1:data_size(1)
    if mapa(i,3) > prah
        tridy = tridy + 1;
    end 
end
output_args = tridy;
end

