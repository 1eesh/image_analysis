 %%
%clear all
%load('spn1_70');
%%for spn1
%soline_ring=[96,100,3,13,24,26,38,39,41,43,47,52,63,65,68,71,73,74,76,82,84,85,86,102,103,104];
%soline_focus=[79,49,2,6,7,9,14,15,19,21,23,28,31,32,35,45,49,50,58,60,61,62,64,78,79,80,81,83,90,95,101,106];
%soline_diffused=[16,1,8,10,12,17,18,20,22,25,27,30,33,34,37,40,42,46,53,54,55,56,57,59,66,67,69,72,75,77,91,92,93,94,97,98,99,105,107,108,109,111,112];

soline_ring=find(area_plot>1.5);
soline_diffused=find(area_plot<=1.5 & area_plot>0) ;
soline_focus=find(area_plot==0);

%%for plotting METRIC

%%
    
AVERAGE_spn=[];

%imshow(A_hold)
%hold on; 
for cell_index=1:cell_number, %this mega for loop calculates the COM for all the cells which are taken from the edge output
 

  

%%the average distance between maxima for each cell
   if (size(cell_rok(cell_index).mean,1) >25)
myo_pcc=cell_myosin(cell_index).mean(1:25,:);
rok_pcc=cell_rok(cell_index).mean(1:25,:);
   end

  if (size(cell_rok(cell_index).mean,1) <=25)
myo_pcc=cell_myosin(cell_index).mean(:,:);
rok_pcc=cell_rok(cell_index).mean(:,:);
end


  pcc = xcov(myo_pcc,rok_pcc,0,'coeff');
   
   metric = area_plot(:,cell_index);

   
   AVERAGE_spn=[AVERAGE_spn;metric]; 
   
   

end


%{
    subplot(2,1,1)
 boxplot(AVERAGE_spn)
     title('Boxplot for Pearson product-moment correlation coefficient distribution')
     ylabel('Pearson r (PCC)');
     ylim([-1 1]);
    
     subplot(2,1,2)
    %%plotting the histogram
hist(AVERAGE_spn)
     title('Histogram for Pearson product-moment correlation coefficient(PCC) distribution')
      h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0 .5 .5],'EdgeColor','w');
     ylabel('Frequency(Number of Cells)');
     xlabel('PCC');
%}
%%

    subplot(2,1,1)
 boxplot(AVERAGE_spn)
     title('Boxplot for the Metric')
     ylabel('the Metric');
          ylim([0 3]);

    
     subplot(2,1,2)
    %%plotting the histogram
hist(AVERAGE_spn)
     title('Histogram for the Metric')
      h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0 .5 .5],'EdgeColor','w');
     ylabel('Frequency(Number of Cells)');
     xlabel('the Metric');
%}