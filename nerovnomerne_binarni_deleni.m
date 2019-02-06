% Rozdìlení dat metodou nerovnomìrné binární dìlení do urèeného poètu tøíd
function [ ] = nerovnomerne_binarni_deleni( data, R )
% data = mnozina obrazu
% R = poèet tøíd

data_size = size(data);
tridy2 = zeros(data_size(1), (R * 2) - 2);
zkresleni = zeros((R * 2) - 2,1);
stredy = zeros(2, (R * 2) - 2);
data_tmp = data;

for i = 2:R
   [tridy_tmp, stredy_tmp, zkresleni_tmp] = k_means_ner_bin_del(data_tmp);
   zkresleni((((i-2)*2)+1),1) = zkresleni_tmp(1);
   zkresleni((((i-2)*2)+2),1) = zkresleni_tmp(2);
   for j = 1:size(tridy_tmp)
       tridy2(tridy_tmp(j,3),(((i-2)*2)+1)) = tridy_tmp(j,1);
       tridy2(tridy_tmp(j,3),(((i-2)*2)+2)) = tridy_tmp(j,2);
   end
   stredy(1,(((i-2)*2)+1)) = stredy_tmp(1,1);
   stredy(2,(((i-2)*2)+1)) = stredy_tmp(1,2);
   stredy(1,(((i-2)*2)+2)) = stredy_tmp(2,1);
   stredy(2,(((i-2)*2)+2)) = stredy_tmp(2,2);
   
   if i == R
       break
   else
       [~,I] = max(zkresleni);
       c = 1;
       for j = 1:data_size(1) % sestaveni dat pro dalsi deleni
           tmp = isnan(tridy2(j,I));
           if tmp == 0
               data_dalsi_deleni(c,1) = tridy2(j,I);
               c = c + 1;
           end
       end
       
       
       d = size(data_dalsi_deleni);
       data_tmp = zeros(d(1),2);
       for j = 1:d(1)
           if data_dalsi_deleni(j) == 0
               data_tmp(j,:) = [0,0];
           else
           data_tmp(j,:) = data(data_dalsi_deleni(j),:);
           end
       end
       
       tridy2(:,I) = 0;
       stredy(:,I) = 0;
       data_dalsi_deleni = 0;
       zkresleni(I) = 0;
   end
end


%% vykreslení
figure('Name','2_nerovnomerne_bin_del');
colors = [0 0 1; 0 0.5 0; 1 0 0; 0.75 0 0.75; 0 0.75 0.75; 0.75 0.75 0; 0 0 0];
% Remove zero columns
tridy2( :, all(~tridy2,1) ) = [];
d = size(tridy2);
% vykreslení bodù
for i = 1:data_size(1)
    for j = 1:d(2)
        tmp = isnan(tridy2(i,j));
        if (tridy(i,j) ~= 0) & (tmp == 0)
            scatter(data(tridy2(i,j),1), data(tridy2(i,j),2),[], colors(j,:),'x')
            hold on
        end
    end
end

% vykreslení støedù
% Remove zero columns
stredy( :, all(~stredy,1) ) = [];
d = size(stredy);
for i = 1:d(2)
    scatter(stredy(1,i), stredy(2,i),[], colors(7,:),'filled')
end
title('Nerovnomìrné binární dìlení - rozdìlení dat do shlukù')
xlabel('x_1')
ylabel('x_2')
end

