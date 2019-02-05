% Rozdìlení bodù pomocí klasifikátoru s minimální vzdáleností
function [ ] = minimalni_vzdalenost( tridy, stredy )
% tridy = rozdìlení bodù do shlukù
% stredy = støedy shlukù

data_size = size(tridy);
[pocet_shluku,~] = size(stredy); % poèet shlukù
velikost_shluku = zeros(1, pocet_shluku); % poèet bodù v jednotlivých shlucích

% zjištìní poètu bodù ve shlucích
for i = 1:data_size(1)
    velikost_shluku(tridy(i,3)) = velikost_shluku(tridy(i,3)) + 1;
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

% møížka bodù
rastr = 0.5;
x = (min(tridy(:,1))-0.1):rastr:(max(tridy(:,1))+0.1);
y = (min(tridy(:,2))-0.1):rastr:(max(tridy(:,2))+0.1);

% výpoèet diskriminaèní funkce, zaøazení bodu a vykreslení møížky
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
figure
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

% vykreslení bodù
for i = 1:data_size(1)   
    scatter(tridy(i,1), tridy(i,2),[], colors(tridy(i,3),:),'x')
end

% vykreslení støedù
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
title('Klasifikátor podle minimální vzdálenosti')

end

