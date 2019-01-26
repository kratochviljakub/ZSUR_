inicializace

%% 1
%a)
tridy(1) = shlukove_hladiny(data);
% b)
tridy(2) = retezove_mapy(data, 5);
% c)
tridy(3) = maximin(data, 0.3);

pocet_trid = (tridy(1) + tridy(2) + tridy(3)) / 3;
pocet_trid = round(pocet_trid);   

%% 2
tic
[tridy_data, stredy] = k_means(data, pocet_trid);
toc

%%
figure
colors = [0 0 1; 0 0.5 0; 1 0 0; 0 0.75 0.75; 0.75 0 0.75; 0.75 0.75 0; 0 0 0];
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