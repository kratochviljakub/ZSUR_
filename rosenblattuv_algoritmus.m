% Rozd�len� prostoru pomoc� Rosenblattova algoritmu
function [ ] = rosenblattuv_algoritmus( tridy, stredy )
% tridy = rozd�len� bod� do shluk�
% stredy = st�edy shluk�

data_size = size(tridy);
[pocet_shluku,~] = size(stredy); % po�et shluk�

% inicializace p��mek n�hodn�mi hodnotami
q = cell(1,pocet_shluku);
for i = 1:pocet_shluku
    q{i} = rand(data_size(2),1);
end

% tr�nov�n�
iterace = 0;
for i = 1:pocet_shluku
    while true
        error = 0;
        for j = 1:data_size(1)
            x = [1 tridy(j, 1) tridy(j,2)]';
            
            if tridy(j,3) == i
                omega = 1;
            else
                omega = -1;
            end
            
            tmp = q{i}' * x * omega;
            
            if tmp < 0
                q{i} = q{i} + (x * omega);
                error = error + 1;
            end
        end
        iterace = iterace + 1;
        if error == 0
            break
        end
    end
end
                





% m��ka bod�
rastr = 0.5;
x = (min(tridy(:,1))-0.1):rastr:(max(tridy(:,1))+0.1);
y = (min(tridy(:,2))-0.1):rastr:(max(tridy(:,2))+0.1);


% vykreslen�
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
figure
hold on
for i = x
    for j = y
        for k = 1:pocet_shluku
            tmp = q{k}(2)*i + q{k}(3)*j + q{k}(1);
            if tmp >= 0
                list(k) = 1;
            else 
                list(k) = 0;
            end
        end
        
        if sum(list) == 1
            [~,I] = max(list);
            scatter(i, j,[], colors(I,:),'h')
        else
            scatter(i, j,[], [0.8 0.8 0.8],'h')
        end
    end
end

%% vykreslen� p��mek
 lim_x = xlim;
 lim_y = ylim;
for i = 1:pocet_shluku
    y = (-q{i}(2)*x -q{i}(1))/q{i}(3);
    plot(x,y,'Color', colors(i,:))
end
xlim(lim_x)
ylim(lim_y)

%vykreslen� bod�
for i = 1:data_size(1)   
    scatter(tridy(i,1), tridy(i,2),[], colors(tridy(i,3),:),'x')
end

% vykreslen� st�ed�
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
title('Rosenblatt�v algoritmus')

txt = strcat('Po�et iterac�: ', num2str(iterace));
text(lim_x(1), lim_y(1)+2, txt)
end

