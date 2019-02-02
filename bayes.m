% Rozdìlení dat metodou k-means do urèeného poètu tøíd
function [ ] = bayes( tridy, stredy )
% tridy = rozdìlení bodù do shlukù
% stredy = støedy shlukù
% zkresleni = kriteriální funkce J


data_size = size(tridy);
[pocet_shluku,~] = size(stredy); % poèet shlukù
velikost_shluku = zeros(1, pocet_shluku); % poèet bodù v jednotlivých shlucích

% zjištìní poètu bodù ve shlucích
for i = 1:data_size(1)
    velikost_shluku(tridy(i,3)) = velikost_shluku(tridy(i,3)) + 1;
end

% vypoètení apriorních pravdìpodobností shlukù
P_omega = zeros(1,pocet_shluku);
for i = 1:pocet_shluku
    P_omega(i) = velikost_shluku(i) / data_size(1);
end

% výpoèet støedních hodnot Gaussovského (normálního) rozdìlení
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

% výpoèet kovarianèní matice Gaussovského (normálního) rozdìlení
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

% møížka bodù pro výpoèet Gaussova (normálního) rozdìlení
rastr = 0.2;
x1 = min(tridy(:,1)):rastr:max(tridy(:,1));
x2 = min(tridy(:,2)):rastr:max(tridy(:,2));
[X1,X2] = meshgrid(x1,x2);

% výpoèet Gaussovo rozdìlení
for i = 1:pocet_shluku
    tmp_gauss = mvnpdf([X1(:) X2(:)],mi(1,:),sigma{1});
    tmp_gauss = reshape(tmp_gauss,length(x2),length(x1));
    gauss{i} = tmp_gauss;
end




%% vykreslení
figure
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
% vykreslení bodù
for i = x1
    for j = x2
        scatter(i, j,[], colors(tridy(i,3),:),'x')
        hold on
    end
end

% vykreslení støedù
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end

title('Aplikování iterativní optimalizace na k-means')
end

