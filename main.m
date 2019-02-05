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
[tridy, stredy, J] = k_means(data, pocet_trid);
nerovnomerne_binarni_deleni(data, pocet_trid);

%% 3
iterativni_optimalizace(tridy, stredy, J);   

%% 4
% a)
bayes(tridy, stredy);
% b)
minimalni_vzdalenost(tridy, stredy);
%%
scatter(data(:,1), data(:,2),'x')