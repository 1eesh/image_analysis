   i=1;
for cell_index=start_cell:end_cell%just selecting cell indices for plotting randomly
 %%plot the shadederrorbars
   
    cell(cell_index).mean';
    %plot(mean_C')
    
    subplot(2,5,i);%subtract the first index -1 here so that the subplot input never goes above 20
 % imshow( cell(cell_index).ANS);
    
   %hold on;
  if(rok)
   shadedErrorBar(1:size( cell(cell_index).mean',2), cell(cell_index).mean',cell(cell_index).stdev,'g');
  end
   if(~rok)
   shadedErrorBar(1:size( cell(cell_index).mean',2), cell(cell_index).mean',cell(cell_index).stdev,'r');
  end
    axis([0,40,0,190]);
     title(cell(cell_index).index)
     hold on
 i=i+1;
end


