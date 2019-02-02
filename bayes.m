% Rozd�len� dat metodou k-means do ur�en�ho po�tu t��d
function [ ] = bayes( tridy, stredy )
% tridy = rozd�len� bod� do shluk�
% stredy = st�edy shluk�
% zkresleni = kriteri�ln� funkce J


data_size = size(tridy);
[pocet_shluku,~] = size(stredy); % po�et shluk�
velikost_shluku = zeros(1, pocet_shluku); % po�et bod� v jednotliv�ch shluc�ch

% zji�t�n� po�tu bod� ve shluc�ch
for i = 1:data_size(1)
    velikost_shluku(tridy(i,3)) = velikost_shluku(tridy(i,3)) + 1;
end

% vypo�ten� apriorn�ch pravd�podobnost� shluk�
P_omega = zeros(1,pocet_shluku);
for i = 1:pocet_shluku
    P_omega(i) = velikost_shluku(i) / data_size(1);
end

% v�po�et st�edn�ch hodnot Gaussovsk�ho (norm�ln�ho) rozd�len�
mi = zeros(pocet_shluku,2);
for i = 1:pocet_shluku
    for j = 1:data_size(1)
        if tridy(j,3) == i
            mi(i,1) = mi(i,1) + tridy(j,1);
            mi(i,2) = mi(i,2) + tridy(j,2);
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
        if tridy(j,3) == i
            tmp(1) = tridy(j,1) - mi(i,1);
            tmp(2) = tridy(j,2) - mi(i,2);
            tmp_sigma = tmp_sigma + (tmp' * tmp);
        end
    end
    tmp_sigma = tmp_sigma / velikost_shluku(i);
    sigma{i} = tmp_sigma;
end

% m��ka bod� pro v�po�et Gaussova (norm�ln�ho) rozd�len�
rastr = 0.2;
x1 = min(tridy(:,1)):rastr:max(tridy(:,1));
x2 = min(tridy(:,2)):rastr:max(tridy(:,2));
[X1,X2] = meshgrid(x1,x2);

% v�po�et Gaussovo rozd�len�
for i = 1:pocet_shluku
    tmp_gauss = mvnpdf([X1(:) X2(:)],mi(1,:),sigma{1});
    tmp_gauss = reshape(tmp_gauss,length(x2),length(x1));
    gauss{i} = tmp_gauss;
end




%% vykreslen�
figure
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
% vykreslen� bod�
for i = x1
    for j = x2
        scatter(i, j,[], colors(tridy(i,3),:),'x')
        hold on
    end
end

% vykreslen� st�ed�
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end

title('Aplikov�n� iterativn� optimalizace na k-means')
end

