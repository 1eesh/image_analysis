%% Here we try and get the Covariance as a function of the distance between maximas(basically we try and see whether the maximas in Pearson corelation correspond to the lag equal to the maximal distance
load('spn');
cell_index=100; %%which cell we are looking at
pcc_tick=6;


%%the average distance between maxima for each cell
myo_pcc=cell_myosin(cell_index).mean(1:25,:);
rok_pcc=cell_rok(cell_index).mean(1:25,:);


subplot(2,1,1)
plot(myo_pcc);
grid on;
hold on;
plot(rok_pcc);

subplot(2,1,2)
% Plot lag vs intensity
pcc_lag=xcov(myo_pcc,rok_pcc,pcc_tick,'coeff')
plot(pcc_lag)
set(gca,'XTick', [0:1:2*pcc_tick+1] )
set(gca,'XTickLabel',[-pcc_tick:1:pcc_tick] ); 
%# vertical line of error bars between the two(because I am not using point of maximum intensity as center but I am using the point of 15% threshold as center
hx_1 = graph2d.constantline(cell(cell_index).average_maxima_distance+pcc_tick, 'Color',[1 0 0]);

changedependvar(hx_1,'x');
grid on;

%#

cell(cell_index).average_maxima_distance