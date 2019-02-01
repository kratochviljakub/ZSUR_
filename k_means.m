% Rozd�len� dat metodou k-means do ur�en�ho po�tu t��d
function [ tridy, mi, zkresleni ] = k_means( data, R )
% data = mnozina obrazu
% R = po�et t��d
% vrac� [data ve t��d�ch, st�edy, kriteri�ln� funkce J]

data_size = size(data);
tridy = data;
c = 0; %zastavovac� counter

% n�hodn� volba po��te�n�ch st�ed�
mi = zeros(R,2);
tmp = zeros(R,1);
while true
    for i = 1:R
        r = 1 + (data_size(1)-1)*rand(1); % n�hodn� ��slo po��te�n�ho bodu
        r = round(r);
        tmp(i) = r;
    end
    if size(unique(tmp),1) == R
        break;
    end
end
%tmp = [1 2 3 4];
for i = 1:R
    mi(i,:) = data(tmp(i),:);
end
   

% algoritmus
while true
    % vzd�lenosti mi a ostatn�ch bod�
    matice = zeros(R,data_size(1));
    for i = 1:size(mi,1)
        for j = 1:data_size(1)
            matice(i,j) = sum((mi(i,:) - data(j,:)).^2);
        end
    end
    
    % rozd�len� dat do t��d
    zkresleni = zeros(R,1);
    for i = 1:data_size(1)
        [M,I] = min(matice(:,i));
        tridy(i,3) = I;
        zkresleni(I) = zkresleni(I) + M;
    end
    
    % p�epo�ten� st�ed� shluk�
    mi_new = mi;
    for i = 1:R
        suma = zeros(1,data_size(2));
        counter = 0;
        for j = 1:data_size(1)
            if tridy(j,3) == i
                for k = 1:data_size(2)
                    suma(k) = suma(k) + tridy(j,k);
                end
                counter = counter + 1;
            end
        end
        suma = suma / counter;
        mi_new(i,:) = suma;
    end
    
    if mi_new == mi % kontrola ukon�ovac� podm�nky
        break;
    else
        mi = mi_new;
        if c > 5000
            disp('N�co se pokazilo v k-means, metoda v�as nedokonvergovala');
            break;
        end
    end
    c = c + 1; %zastavovaci counter
end


%% test data
% data = [0 1; 2 1; 1 3; 1 -1; 1 5; 1 9; -1 7; 3 7];

%% vykreslen�
figure
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
% vykreslen� bod�
for i = 1:data_size(1)   
    scatter(tridy(i,1), tridy(i,2),[], colors(tridy(i,3),:),'x')
    hold on
end

% vykreslen� st�ed�
for i = 1:size(mi)
    scatter(mi(i,1), mi(i,2),[], colors(7,:),'filled')
end
output = 1;
title('Metoda k-means - rozd�len� dat do shluk�')
end

