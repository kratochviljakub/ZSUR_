% Rozd�len� bod� pomoc� klasifik�toru s minim�ln� vzd�lenost�
function [ ] = minimalni_vzdalenost( tridy2, stredy )
% tridy = rozd�len� bod� do shluk�
% stredy = st�edy shluk�

data_size = size(tridy2);
[pocet_shluku,~] = size(stredy); % po�et shluk�
velikost_shluku = zeros(1, pocet_shluku); % po�et bod� v jednotliv�ch shluc�ch

% zji�t�n� po�tu bod� ve shluc�ch
for i = 1:data_size(1)
    velikost_shluku(tridy2(i,3)) = velikost_shluku(tridy2(i,3)) + 1;
end

% v�po�et st�edn�ch hodnot Gaussovsk�ho (norm�ln�ho) rozd�len�
mi = zeros(pocet_shluku,2);
for i = 1:pocet_shluku
    for j = 1:data_size(1)
        if tridy2(j,3) == i
            mi(i,1) = mi(i,1) + tridy2(j,1);
            mi(i,2) = mi(i,2) + tridy2(j,2);
        end
    end
    mi(i,:) = mi(i,:) / velikost_shluku(i);
end

% m��ka bod�
rastr = 0.5;
x = (min(tridy2(:,1))-0.1):rastr:(max(tridy2(:,1))+0.1);
y = (min(tridy2(:,2))-0.1):rastr:(max(tridy2(:,2))+0.1);

% v�po�et diskrimina�n� funkce, za�azen� bodu a vykreslen� m��ky
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
figure('Name','4b_min_vzdalenost');
hold on
for i = x
    for j = y
        g = zeros(1,pocet_shluku);
        for k = 1:pocet_shluku
            g(k) = (i - mi(k,1))^2 + (j - mi(k,2))^2;
        end
        [~,I] = min(g);
        scatter(i, j,[], colors(I,:),'h')
    end
end

% vykreslen� bod�
for i = 1:data_size(1)   
    scatter(tridy2(i,1), tridy2(i,2),[], colors(tridy2(i,3),:),'x')
end

% vykreslen� st�ed�
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
title('Klasifik�tor podle minim�ln� vzd�lenosti')
xlabel('x_1')
ylabel('x_2')

end

