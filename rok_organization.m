%% This script calculates the half life of the Rok Plots to be able to show that the half life increases and hence to be able to say that the Rok is diffused and is not centered anymore like it used to be

%% Here we try and get the Covariance as a function of the distance between maximas(basically we try and see whether the maximas in Pearson corelation correspond to the lag equal to the maximal distance



%%instead of taking all the area under the curve i will take the area from x=0 to x=(the place where graph comes back to y at x=0)
 %%
load('spn_rokxmyosin');


if 1 %% this segment of the code fits a pokynomial to the plot of Rok intensity and then plots the polynomial on to the Rok plot
area=[];

for cell_index=1:cell_number, %%which cell we are looking at
    
    %%this segment normalizes the intensities between zero and one for each
  %%cell individually
    [rmx,t]=max(cell_rok(cell_index).mean);
    %[rmn,t]=min(cell_rok(cell_index).mean);
    
   
    cell_rok(cell_index).mean = cell_rok(cell_index).mean/(rmx) ; 
    cell_rok(cell_index).mean = (2/cell_rok(cell_index).mean(1,1))*cell_rok(cell_index).mean ;

   
  

  %%
    
if(cell(cell_index).average_maxima_distance <=8 ) % this helps us ignore the outliers
      
    if (size(cell_rok(cell_index).mean,1) >25)
        y=cell_rok(cell_index).mean(1:25,:)';
        x=[1:1:25];
        p=polyfit(x,y,7);
    
        f = polyval(p,x);
       plot(x,y,'o',x,f,'-')
    end

    if (size(cell_rok(cell_index).mean,1) <=25)
        y=cell_rok(cell_index).mean(:,:)';
        x=[1:1:size(cell_rok(cell_index).mean,1)];
        p=polyfit(x,y,10);
    
        f = polyval(p,x);
       plot(x,y,'o',x,f,'-')
    end
hold on
end %ignoring the outliers

f=f(:,1:7);
area = [area trapz(f)];

end

k=waitforbuttonpress;
hold off;

var(area)
scatter([1:1:cell_number],area);
grid on;
grid minor;
end











%% I tried the average slope but that method failed to give me useful output to distinguish between the plots : DOES NOT WORK

if 0
average_slope=[];

for cell_index = 1:cell_number,
    
    average_slope=[average_slope (cell_rok(cell_index).mean(10) - cell_rok(cell_index).mean(1) )/10 ];
    
end

scatter([1:1:cell_number],average_slope);
hy = graph2d.constantline(0, 'Color',[0 0 0]);
changedependvar(hy,'y');
end
