% Rozd�len� bod� pomoc� klasifik�toru podle nejbli���ho souseda
function [ ] = nejblizsi_soused( tridy, stredy )
% tridy = rozd�len� bod� do shluk�
% stredy = st�edy shluk�

data_size = size(tridy);
[pocet_shluku,~] = size(stredy); % po�et shluk�
pocet_etalonu = 10; % po�et etalon� pro ka�dou t��du

% v�b�r etalon�
etalony = cell(1,pocet_shluku);
etalony(:) = {zeros(pocet_etalonu,2)};
for i = 1:pocet_shluku
    counter = 1;
    for j = 1:data_size(1)
        if tridy(j,3) == i
            etalony{i}(counter,1) = tridy(j,1);
            etalony{i}(counter,2) = tridy(j,2);
            counter = counter + 1;
        end
        if counter > pocet_etalonu
            break;
        end
    end        
end

% m��ka bod�
rastr = 0.5;
x = (min(tridy(:,1))-0.1):rastr:(max(tridy(:,1))+0.1);
y = (min(tridy(:,2))-0.1):rastr:(max(tridy(:,2))+0.1);

% v�po�et diskrimina�n� funkce, za�azen� bodu a vykreslen� m��ky
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
f = figure
hold on
for i = x
    for j = y
        g = zeros(pocet_etalonu*pocet_shluku,1);
        for k = 1:pocet_shluku
            for m = 1:pocet_etalonu
                g((k-1)*10+m) = (i - etalony{k}(m,1))^2 + (j - etalony{k}(m,2))^2;
            end
        end
        [~,I] = min(g);
        scatter(i, j,[], colors((fix((I-1)/10)+1),:),'h')
    end
end

% vykreslen� bod�
for i = 1:data_size(1)   
    scatter(tridy(i,1), tridy(i,2),[], colors(tridy(i,3),:),'x')
end

% vykreslen� st�ed�
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
title('Klasifik�tor podle nejbli���ho souseda')

end

