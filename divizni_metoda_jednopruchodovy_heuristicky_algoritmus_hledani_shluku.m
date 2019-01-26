% jednoprùchodový heuristický algoritmus hledání shlukù
function [ output_args ] = shlukove_hladiny( data, t )
% data = mnozina obrazu
% t = mira podobnosti t > 0
% vrací [ poèet hladin    rozdìlení dat do hladin ]

data_size = size(data);
my(1,:) = data(1,:); % støed prvního shluku
T = zeros(data_size(1),1); 
T(1) = 1; % pøedstavuje do kterého shluku patøí data(i)

for i = 2:data_size(1)    
    for j = 1:my_size(1)
        d(j) = norm(data(i) - my(j)); %vzdálenost dvou bodù
        if d(j) <= t
            T(i) = j;
            break
        end
    end
    if T(i) == 0
        my(my_size(1) + 1,:) = data(i,:);
        T(i) = my_size(1) + 1;
    end
    my_size = size(my);
end

output_args = [ ];

end

