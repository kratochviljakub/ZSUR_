inicializace

%% 1
%a)
tic
tridy(1) = shlukove_hladiny(data);
toc

%% b)
tic
tridy(2) = retezove_mapy(data, 80);
toc

%% c)
tic
tridy(3) = maximin(data, 0.3);
toc  
            
%% 2
tic
[tridy_data, stredy] = k_means(data, tridy(1));
toc

% P������I VOLE - n�co tam nefunguje a j� nevim co. D�l� to na kundu a
% mus�m p�ij�t na to pro�. Seru se s t�m takovou dobu a za 5 hodin vst�v�m
% do fachu. Mrdat.
%%
figure
% vykreslen� bod�
for i = 1:size(data)    
    scatter(tridy_data(i,1), tridy_data(i,2),[], colors(tridy_data(i,3),:))
    hold on
end

% vykreslen� st�ed�
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
    
%%
scatter(data(:,1), data(:,2))