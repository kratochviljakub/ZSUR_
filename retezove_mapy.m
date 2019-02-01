% urèení poètu tøíd metodou retezove mapy
function [ output_args ] = retezove_mapy( data, t )
% data = mnozina obrazu
% t = konstanta ovlivòující prahovou hodnotu rozdìlení tøíd
% vrací [ poèet tøíd ]

data_size = size(data);
mapa = zeros(data_size(1),3);
r = 1 + (data_size(1)-1)*rand(1); % nahodne cislo poèáteèního bodu
r = round(r);
mapa(1,1) = data(r,1);
mapa(1,2) = data(r,2);

% generování matice vzdáleností
matice = zeros(data_size(1));
for i = 1:data_size(1)    
    for j = i + 1:data_size(1)
        matice(i,j) = sum((data(i,:)-data(j,:)).^2); %vzdálenost dvou bodù
        matice(j,i) = matice(i,j); %matice je symetrická
    end
end

matice(matice == 0 ) = NaN;
for k = 2:data_size(1)  
    % hledání minima
    %matice(matice == 0 ) = NaN; % zmìní nulové vzdálenosti na NaN
    [M,I] = min(matice(r,:)); %M = hodnota, I = pozice
    %matice(isnan(matice)) = 0; % zmìní NaN zpìt na nulové vzdálenosti

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

%% vykreslení
figure
plot(mapa(:,1),mapa(:,2))
title('Metoda øetìzové mapy - mapa')

figure
plot(mapa(:,3))
title('Metoda øetìzové mapy - prùbìh tvorby vzdálenostní mapy')
xlabel('Index vzdálenosti')
ylabel('Vzdálenost mezi nejblišími body')

%% urèení poètu tøíd
prah = max(mapa(:,3)) / t;

tridy = 1;
for i = 1:data_size(1)
    if mapa(i,3) > prah
        tridy = tridy + 1;
    end 
end
output_args = tridy;
end

