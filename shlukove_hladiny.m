% ur�en� po�tu t��d metodou shlukov� hladiny (aglomerativn� metoda)
function [ output_args ] = shlukove_hladiny( data )
% data = mnozina obrazu
% vrac� [ po�et t��d ]

t = 1; %m�ra podobnosti
data_size = size(data);
hladiny = zeros(data_size(1),1);


% generov�n� matice vzd�lenost�
matice = zeros(data_size(1));
for i = 1:data_size(1)    
    for j = i + 1:data_size(1)
        matice(i,j) = sum((data(i,:)-data(j,:)).^2); %vzd�lenost dvou bod�
        matice(j,i) = matice(i,j); %matice je symetrick�
    end
end

for k = 1:data_size(1) - 1
    % hled�n� minima
    matice(matice == 0 ) = NaN; % zm�n� nulov� vzd�lenosti na NaN
    [~,I] = min(matice(:));
    [I_radek, I_sloupec] = ind2sub(size(matice),I);
    matice(isnan(matice)) = 0; % zm�n� NaN zp�t na nulov� vzd�lenosti

    hladiny(k) = matice(I_radek, I_sloupec);
    % redukce matice
    for i = 1:size(matice)
        if matice(I_radek, i) > matice(I_sloupec, i)
            matice(I_radek, i) = matice(I_sloupec, i);
            matice(i, I_radek) = matice(i, I_sloupec);
        else
            matice(i, I_sloupec) = matice(i, I_radek);
            matice(I_sloupec, i) = matice(I_radek, i);
        end
    end
    matice(I_radek,:) = [];
    matice(:,I_radek) = [];
end
hladiny(end) = hladiny(end - 1);


%% test data
% data = [-3 1; 1 1; -2 0; 3 -3; 1 2; -2 -1;];
%     
% output_args = [ ];


%%
tridy = 0;
soucet = 0;
rozptyl = max(hladiny) - min(hladiny);
for i = 1:data_size(1)
    soucet = soucet + hladiny(i);
end
prumer = soucet / data_size(1);
for i = 1:data_size(1)
    if hladiny(i) > (prumer * rozptyl * t)
        tridy = tridy + 1;
    end
end
output_args = tridy;

%% vykreslen�
figure
plot(hladiny((data_size(1) - (tridy*4)):end));
title('Metoda shlukov� hladiny - vykreslen� podmno�iny nejvy���ch hodnot h')
ylabel('Velikost h')

%%
% tridy = 0;
% flipped = flip(hladiny);
% for i = 1:data_size(1)-1
%     if flipped(i) / t >= flipped(i+1)
%         tridy = tridy + 1;
%     else
%         break
%     end
% end
% output_args = tridy;
end

