%% Here we try and get the Covariance as a function of the distance between maximas(basically we try and see whether the maximas in Pearson corelation correspond to the lag equal to the maximal distance
load('spn');
cell_index=2; %%which cell we are looking at



%%the average distance between maxima for each cell
myo_pcc=cell_myosin(cell_index).mean(1:25,:);
rok_pcc=cell_rok(cell_index).mean(1:25,:);

subplot(2,1,1)
plot(myo_pcc);
grid on;
set(gca,'Xtick',01:25)
hold on;
plot(rok_pcc);

subplot(2,1,2)
% Plot lag vs intensity
pcc_lag=xcov(myo_pcc,rok_pcc,6,'coeff')
plot(pcc_lag);
%# vertical line of error bars between the two(because I am not using point of maximum intensity as center but I am using the point of 15% threshold as center
hx_1 = graph2d.constantline(cell(cell_index).average_maxima_distance+7, 'LineStyle',':', 'Color',[1 0 0]);
hx_2 = graph2d.constantline(-cell(cell_index).average_maxima_distance+7, 'LineStyle',':', 'Color',[1 0 0]);
changedependvar(hx_1,'x');
changedependvar(hx_2,'x');
axis([0,13,0,1]);
%#

cell(cell_index).average_maxima_distance