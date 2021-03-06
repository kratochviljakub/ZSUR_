% Rozd�len� bod� pomoc� klasifik�toru podle nejbli���ho souseda
% a podle k-nejbli���ch soused�
function [ ] = nejblizsi_soused( tridy, stredy )
% tridy = rozd�len� bod� do shluk�
% stredy = st�edy shluk�

data_size = size(tridy);
[pocet_shluku,~] = size(stredy); % po�et shluk�

pocet_etalonu = zeros(pocet_shluku,1);
for i = 1:data_size(1)
    for j = 1:pocet_shluku
        if tridy(i,3) == j
            pocet_etalonu(j) = pocet_etalonu(j) + 1;
        end
    end
end


% v�b�r etalon�
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


% m��ka bod�
rastr = 0.5;
x = (min(tridy(:,1))-0.1):rastr:(max(tridy(:,1))+0.1);
y = (min(tridy(:,2))-0.1):rastr:(max(tridy(:,2))+0.1);


%% nejbli��� soused
% v�po�et diskrimina�n� funkce, za�azen� bodu a vykreslen� m��ky
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

% vykreslen� bod�
for i = 1:data_size(1)   
    scatter(tridy(i,1), tridy(i,2),[], colors(tridy(i,3),:),'x')
end

% vykreslen� st�ed�
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
title('Klasifik�tor podle nejbli���ho souseda')
xlabel('x_1')
ylabel('x_2')


%% k nejbli���ch soused�
k_sousedu = 2;

% v�po�et diskrimina�n� funkce, za�azen� bodu a vykreslen� m��ky
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

% vykreslen� bod�
for i = 1:data_size(1)   
    scatter(tridy(i,1), tridy(i,2),[], colors(tridy(i,3),:),'x')
end

% vykreslen� st�ed�
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
title('Klasifik�tor podle k-nejbli���ch soused�')
xlabel('x_1')
ylabel('x_2')

lim_x = xlim;
lim_y = ylim;

txt = strcat('Po�et soused�: ', num2str(k_sousedu));
text(lim_x(1), lim_y(1)+2, txt)

end

