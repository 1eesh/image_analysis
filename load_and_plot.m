
%%
load('wildtype_rokxmyosin.mat')
  
    start_cell=78;
    end_cell=79;
    
     %%MYOSIN PLOT
 cell=cell_myosin;
 rok=0;%this is just for plotting
  run('/Users/eesh/Desktop/image_analysis/plot_radial.m');

    %%ROK PLOT
    cell=cell_rok;
    rok=1;
    run('/Users/eesh/Desktop/image_analysis/plot_radial.m');

%%
    
%%PLOTTING the AVERAGE intensity Distribution for The Cell
if 0,
k=waitforbuttonpress;
    hold off;
%%   
wild=1;
load('wildtype_rokxmyosin.mat')
%%PLOT FOR MYOSIN AVERAGE IVER CELLS 
 cell=cell_myosin;
    rok=0;
   
 run('/Users/eesh/Desktop/image_analysis/averageovercells.m');
 wild_myosin=average_C(1:30,:);
%%PLOT FOR ROK AVERAGE OVER CELLS 
 cell=cell_rok;
rok=1;

 run('/Users/eesh/Desktop/image_analysis/averageovercells.m'); 
  wild_rok=average_C(1:30,:);
WILD_corr=xcov(wild_myosin,wild_rok,0,'coeff')
 title('Average over all the cells for Wild type Mutant');
 xlabel(strcat('Peason correlation coefficient for the Average plots = ',num2str(WILD_corr)));
 %%THIS IS FOR SPN(average thing
 
 wild=0;
 load('spn_rokxmyosin.mat')
%%PLOT FOR MYOSIN AVERAGE IVER CELLS 
 cell=cell_myosin;
    rok=0;
  subplot(2,1,2)   
 run('/Users/eesh/Desktop/image_analysis/averageovercells.m');
  spn_myosin=average_C(1:30,:);
 title('Average over all the cells for Spn Mutant');
%%PLOT FOR ROK AVERAGE OVER CELLS 
 cell=cell_rok;
rok=1;

 run('/Users/eesh/Desktop/image_analysis/averageovercells.m'); 
 spn_rok=average_C(1:30,:);
 
 SPN_corr=xcov(spn_myosin,spn_rok,0,'coeff')
 xlabel(strcat('Peason correlation coefficient for the Average plots = ',num2str(SPN_corr)));
end