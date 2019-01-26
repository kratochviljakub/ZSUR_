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

% PÍÍÍÍÍÈI VOLE - nìco tam nefunguje a já nevim co. Dìlí to na kundu a
% musím pøijít na to proè. Seru se s tím takovou dobu a za 5 hodin vstávám
% do fachu. Mrdat.
%%
figure
% vykreslení bodù
for i = 1:size(data)    
    scatter(tridy_data(i,1), tridy_data(i,2),[], colors(tridy_data(i,3),:))
    hold on
end

% vykreslení støedù
for i = 1:size(stredy)
    scatter(stredy(i,1), stredy(i,2),[], colors(7,:),'filled')
end
    
%%
scatter(data(:,1), data(:,2))