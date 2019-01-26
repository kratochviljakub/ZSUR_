filename = 'data.txt';

data = load(filename);
colors = [0 0 1; 0 0.5 0; 1 0 0; 0 0.75 0.75; 0.75 0 0.75; 0.75 0.75 0; 0 0 0];
scatter(data(:,1), data(:,2))

clear filename