% Rozd�len� bod� pomoc� Bayesova klasifik�toru
function [ ] = bayes( tridy2, stredy )
% tridy = rozd�len� bod� do shluk�
% stredy = st�edy shluk�


data_size = size(tridy2);
[pocet_shluku,~] = size(stredy); % po�et shluk�
velikost_shluku = zeros(1, pocet_shluku); % po�et bod� v jednotliv�ch shluc�ch

% zji�t�n� po�tu bod� ve shluc�ch
for i = 1:data_size(1)
    velikost_shluku(tridy2(i,3)) = velikost_shluku(tridy2(i,3)) + 1;
end

% % vypo�ten� apriorn�ch pravd�podobnost� shluk�
% P_omega = zeros(1,pocet_shluku);
% for i = 1:pocet_shluku
%     P_omega(i) = velikost_shluku(i) / data_size(1);
% end

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

% v�po�et kovarian�n� matice Gaussovsk�ho (norm�ln�ho) rozd�len�
sigma = cell(1,pocet_shluku);
sigma(:) = {zeros(size(stredy,2))};
for i = 1:pocet_shluku
    tmp_sigma = zeros(size(stredy,2));
    for j = 1:data_size(1)
        if tridy2(j,3) == i
            tmp(1) = tridy2(j,1) - mi(i,1);
            tmp(2) = tridy2(j,2) - mi(i,2);
            tmp_sigma = tmp_sigma + (tmp' * tmp);
        end
    end
    tmp_sigma = tmp_sigma / velikost_shluku(i);
    sigma{i} = tmp_sigma;
end

% m��ka bod� pro v�po�et Gaussova (norm�ln�ho) rozd�len�
rastr = 0.5;
x = (min(tridy2(:,1))-0.1):rastr:(max(tridy2(:,1))+0.1);
y = (min(tridy2(:,2))-0.1):rastr:(max(tridy2(:,2))+0.1);
[X,Y] = meshgrid(x,y);

% v�po�et Gaussovo rozd�len�
for i = 1:pocet_shluku
    tmp_gauss = mvnpdf([X(:) Y(:)],mi(i,:),sigma{i});
    tmp_gauss = reshape(tmp_gauss,length(y),length(x));
    gauss{i} = tmp_gauss;
end



%% vykreslen�
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];

% vykreslen� pravd�podobnostn� m��ky
figure
y_in_gauss = 1;
for i = x
    x_in_gauss = 1;
    for j = y
        nejvetsi_pravdepodobnost = 0;
        nejvetsi_pravdepodobnost_k = 0;
        for k = 1:pocet_shluku
            if gauss{k}(x_in_gauss,y_in_gauss) > nejvetsi_pravdepodobnost
                nejvetsi_pravdepodobnost = gauss{k}(x_in_gauss,y_in_gauss);
                nejvetsi_pravdepodobnost_k = k;
            end
            %scatter(i, j,gauss{1}(x_in_gauss, y_in_gauss), colors(tridy(i,3),:),'x')
            %surf(i,j,gauss{1}(x_in_gauss,y_in_gauss));
            
        end
        scatter(i, j,[], colors(nejvetsi_pravdepodobnost_k,:),'h')
        hold on
        x_in_gauss = x_in_gauss + 1;
    end
    y_in_gauss = y_in_gauss + 1;
end

% vykreslen� bod�
for i = 1:data_size(1)   
    scatter(tridy2(i,1), tridy2(i,2),[], colors(tridy2(i,3),:),'x')
    hold on
end

% vykreslen� st�ed�
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
title('Bayes�v klasifik�tor')

% vykreslen� 3D grafu norm�ln�ch rozd�len�
figure
for i = 1:pocet_shluku
    surf(x,y,gauss{i})
    hold on
end
caxis([0 0.1])
title('Gaussovo rozd�len�')
end

