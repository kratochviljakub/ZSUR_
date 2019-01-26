% Rozd�len� dat metodou k-means do ur�en�ho po�tu t��d
function [ output_args1, output_args2 ] = k_means( data, R )
% data = mnozina obrazu
% q = po�et t��d
% vrac� [ data s informac� o rozd�len� do t��d ], [ st�edy t��d ]

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
tmp = [1 2 3 4];
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
    for i = 1:data_size(1)
        [~,I] = min(matice(:,i));
        tridy(i,3) = I;
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
    
    if mi_new == mi
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


%% test data
% data = [0 1; 2 1; 1 3; 1 -1; 1 5; 1 9; -1 7; 3 7];

%%

output_args1 = tridy;
output_args2 = mi;
end

