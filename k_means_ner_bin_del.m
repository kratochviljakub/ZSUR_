% Upraven� metoda k-means pro pot�eby nerovnom�rn�ho bin�rn�ho d�len�
function [ tridy_output, mi, zkresleni ] = k_means_ner_bin_del( data_puvodni )
% data = mnozina obrazu
% R = po�et t��d
% vrac� [ tridy a jejich konkretni body, stredy trid, zkresleni ]
counter = 1;
for i = 1:size(data_puvodni)
    if data_puvodni(i,1) ~= 0
        data(counter,1) = data_puvodni(i,1);
        data(counter,2) = data_puvodni(i,2);
        data(counter,3) = i;
        counter = counter + 1;
    end
end

data_size = size(data);
tridy = data;
c = 0; %zastavovac� counter
pocet_shluku = 2;

% n�hodn� volba dvou po��te�n�ch st�ed�
mi = zeros(pocet_shluku,2);
tmp = zeros(pocet_shluku,1);
while true
    for i = 1:pocet_shluku
        r = 1 + (data_size(1)-1)*rand(1); % n�hodn� ��slo po��te�n�ho bodu
        r = round(r);
        tmp(i) = r;
    end
    if size(unique(tmp),1) == pocet_shluku
        break;
    end
end
%tmp = [1 2 3 4];
for i = 1:pocet_shluku
    mi(i,1) = data(tmp(i),1);
    mi(i,2) = data(tmp(i),2);
end
   

% algoritmus
while true
    % vzd�lenosti mi a ostatn�ch bod�
    matice = zeros(pocet_shluku,data_size(1));
    for i = 1:size(mi,1)
        for j = 1:data_size(1)
            matice(i,j) = sum(((mi(i,1) - data(j,1))^2 + (mi(i,2) - data(j,2))^2));
        end
    end
    
    % rozd�len� dat do t��d
    tridy(:,4) = data(:,3);
    zkresleni = zeros(pocet_shluku,1);
    for i = 1:data_size(1)
        [M,I] = min(matice(:,i));
        tridy(i,3) = I;
        zkresleni(I) = zkresleni(I) + M;
    end
    
    % p�epo�ten� st�ed� shluk�
    mi_new = mi;
    for i = 1:pocet_shluku
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
        mi_new(i,1) = suma(1);
        mi_new(i,2) = suma(2);
    end
   
    if mi_new == mi % kontrola ukon�ovac� podm�nky
        break;
    else
        mi = mi_new;
        if c > 5000
            disp('N�co se pokazilo v k-means');
            break;
        end
    end
    c = c + 1; %zastavovaci counter
end
tridy_output = zeros(data_size(1), 3);
for i = 1:data_size(1)
    if tridy(i,3) == 1
        tridy_output(i,1) = tridy(i,4);
        tridy_output(i,3) = tridy(i,4); 
    else if tridy(i,3) == 2
            tridy_output(i,2) = tridy(i,4);
            tridy_output(i,3) = tridy(i,4);
        end
    end
end

end

