% Rozdìlení bodù pomocí klasifikátoru podle nejbližšího souseda
% a podle k-nejbližších sousedù
function [ ] = nejblizsi_soused( tridy, stredy )
% tridy = rozdìlení bodù do shlukù
% stredy = støedy shlukù

data_size = size(tridy);
[pocet_shluku,~] = size(stredy); % poèet shlukù

pocet_etalonu = zeros(pocet_shluku,1);
for i = 1:data_size(1)
    for j = 1:pocet_shluku
        if tridy(i,3) == j
            pocet_etalonu(j) = pocet_etalonu(j) + 1;
        end
    end
end


% výbìr etalonù
etalony = cell(1,pocet_shluku);
for i = 1:pocet_shluku
    etalony{i} = zeros(pocet_etalonu(i),2);
    counter = 1;
    for j = 1:data_size(1)
        if tridy(j,3) == i
            etalony{i}(counter,1) = tridy(j,1);
            etalony{i}(counter,2) = tridy(j,2);
            counter = counter + 1;
        end
    end        
end


% møížka bodù
rastr = 0.5;
x = (min(tridy(:,1))-0.1):rastr:(max(tridy(:,1))+0.1);
y = (min(tridy(:,2))-0.1):rastr:(max(tridy(:,2))+0.1);


%% nejbližší soused
% výpoèet diskriminaèní funkce, zaøazení bodu a vykreslení møížky
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
figure('Name','4c_nejblizsi_soused');
hold on
for i = x
    for j = y
        g = inf(max(pocet_etalonu),4);
        for k = 1:pocet_shluku
            counter = 1;
            for m = 1:pocet_etalonu(k)
                g(counter,k) = (i - etalony{k}(m,1))^2 + (j - etalony{k}(m,2))^2;
                counter =  counter + 1;
            end
        end
        [~,I] = min(min(g));
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
title('Klasifikátor podle nejbližšího souseda')
xlabel('x_1')
ylabel('x_2')


%% k nejbližších sousedù
k_sousedu = 2;

% výpoèet diskriminaèní funkce, zaøazení bodu a vykreslení møížky
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
figure('Name','4c_k_nejblizsich_sousedu');
hold on
for i = x
    for j = y
        g = inf(max(pocet_etalonu),4);
        for k = 1:pocet_shluku
            counter = 1;
            for m = 1:pocet_etalonu(k)
                g(counter,k) = (i - etalony{k}(m,1))^2 + (j - etalony{k}(m,2))^2;
                counter =  counter + 1;
            end
        end
        g_sorted = g;
        for k = 1:pocet_shluku
            g_sorted(:,k) = sort(g(:,k),1);
        end
        prumer = zeros(pocet_shluku,1);
        for k = 1:pocet_shluku
            for m = 1:k_sousedu
                prumer(k) = prumer(k) + g_sorted(m,k);
            end
            prumer(k) = prumer(k) / k_sousedu;
        end
        [~,I] = min(prumer);
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
title('Klasifikátor podle k-nejbližších sousedù')
xlabel('x_1')
ylabel('x_2')

lim_x = xlim;
lim_y = ylim;

txt = strcat('Poèet sousedù: ', num2str(k_sousedu));
text(lim_x(1), lim_y(1)+2, txt)

end

