% P�evod prom�nn�ch z�skan�ch z metody nerovnom�rn� bin�rn� d�len�
% do tvaru vhodn�ho pro dal�� pou�it�
function [ tridy, stredy, zkresleni ] = prevod_tvaru_promennych( data, bin_tridy, bin_stredy, bin_zkresleni )

stredy = bin_stredy';

tridy = zeros(length(bin_tridy),3);
for i = 1:length(bin_tridy)
    tridy(i,1) = data(i,1);
    tridy(i,2) = data(i,2);
    [~,I] = max(bin_tridy(i,:));
    tridy(i,3) = I;
end

zkresleni = zeros(length(stredy),1);
counter = 1;
for i = 1:length(bin_zkresleni)
    if bin_zkresleni(i) > 0
        zkresleni(counter) = bin_zkresleni(i);
        counter = counter + 1;
    end
end
    


end

