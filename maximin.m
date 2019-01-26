% ur�en� po�tu t��d metodou MAXIMIN
function [ output_args ] = maximin( data, q )
% data = mnozina obrazu
% q = voliteln� konstanta
% vrac� [ po�et t��d ]

data_size = size(data);
r = 1 + (data_size(1)-1)*rand(1); % n�hodn� ��slo po��te�n�ho bodu
r = round(r);
startovni_bod = 7;

mi(1,:) = data(startovni_bod,:);

%matice = zeros(data_size(1), 1);
for i = 1:data_size(1)
    matice(i) = sum((data(startovni_bod,:) - data(i,:)).^2); %vzd�lenost mi(1) a ostatn�ch bod�
end
[~,I] = max(matice); % [hodnota, pozice]
mi(2,:) = data(I,:);
data(startovni_bod,:) = 0;
data(I,:) = 0;

%tmp = zeros(size(mi,1), data_size(1));
while true
    for i = 1:size(mi,1)
       for j = 1:data_size(1)
           tmp(i,j) = sum((mi(i,:) - data(j,:)).^2); %vzd�lenosti v�ech bod� od v�ech st�ed�
       end
    end
    tmp(tmp == 0 ) = NaN;
    
    for i = 1:data_size(1)
        matice(i) = min(tmp(:,i)); % uchovan� minim�ln� vzd�lenosti
    end
    
    C = combnk(1:size(mi,1),2); % kombinace v�ech st�ed�
    avg_stred = 0;
    for i = 1:size(C,1)
        avg_stred = avg_stred + sum(mi(C(i,1),:) - mi(C(i,2),:)).^2;
    end
    avg_stred = avg_stred / size(C,1);
    
    if max(matice) > q*avg_stred 
        [~,I] = max(matice);
        mi(size(mi,1) + 1,:) = data(I,:);
        data(I,:) = 0;
    else
        break
    end
end

%% test data
% data = [2 -3; 3 3; 2 2; -3 1; -1 0; -3 -2; 1 -2; 3 2];

%%

output_args = size(mi,1);
end

