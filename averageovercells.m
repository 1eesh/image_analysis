
max_size=0;
for cell_index=1:cell_number,
    %%this segment normalizes the intensities between zero and one for each
  %%cell individually
    [r,t]=max(cell(cell_index).mean);
    cell(cell_index).mean = cell(cell_index).mean/r ; 

  %%
    
    if(max_size<=size(cell(cell_index).mean)),
        max_size=size(cell(cell_index).mean);
    end
end
max_size;
for cell_index=1:cell_number,
  
    cell(cell_index).mean = vertcat(cell(cell_index).mean,NaN(max_size(1)-size(cell(cell_index).mean,1),1));
end
  
C=[];

for cell_index=1:cell_number,
  
    C=[C cell(cell_index).mean];
end



    average_C = nanmean(C,2);
    stdev_C = nanstd(C',1);

    stdv=stdev_C(:,1:30);
    AVeG=average_C';
    
    %%PLOTTING BEGINS WITH FLAGS
    if(wild)
        subplot(2,1,1) 
    if(rok),
   
 shadedErrorBar(1:1:30, AVeG(:,1:30),stdv,'g');

  hold on
    end
    
      if(~rok),
 
 shadedErrorBar(1:1:30, AVeG(:,1:30),stdv,'r');
 
 hold on
      end
    end
    
    
     if(~wild)
        subplot(2,1,2) 
    if(rok),
   
 shadedErrorBar(1:1:30, AVeG(:,1:30),stdv,'g');
 
  hold on
    end
    
      if(~rok),
 
 shadedErrorBar(1:1:30, AVeG(:,1:30),stdv,'r');
 
  hold on
      end
    end
    