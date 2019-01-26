% nalezení "derivace" diskrétních hodnot
function [ output_args ] = derivace( data )
% data = vstupni hodnoty
% vrací [ derivovaný vstup ]

data_size = size(data);
output_args = zeros(data_size(1),1);

for i = 1:data_size(1) - 1
    output_args(i) = data(i + 1) - data(i);
end

end

