

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
A descritption for the code : 
I have divided the code into 3 different parts and the function of each parts is explained here:
"
PART 1: It runs over all the cells in the image and finds the maximum intensity and location of the maximum intensity for each of the 
maximum intensity distance for each of the cells average intensity distribution plots to NORMALIZE(get it down to 0 and 2)
The normalization can be done on any scale, it wont affect the calculations. All the plots are translated vertically so that 
the at the origin the intensity is 2. Intuitively, you can think of this as an analysis of the change in intensity 
with respect to the intensity at the origin.

PART 2: Now that we have the normalized curve, we want draw a horizontal line and find the first and the last points of intersection 
of the horizontal line on the radial intensity distribution graph with the height same as that at the initial point.
This portion of the code basically returns the two points of intersection of the line and the graph.

PART 3: This part of the code simply finds the area between the horizontal line and the curve.

In all the parts , there conditions on the size of the cell to ignore outliers(for the really weird rok structures) .The rest of the lines in code are just alternate ideas and have been commented out by if 0. And t
"
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PART 1
if 1 %% this segment of the code fits a pokynomial to the plot of Rok intensity and then plots the polynomial on to the Rok plot
area=[];

for cell_index=1:cell_number, %%which cell we are looking at
    
    %%this segment normalizes the intensities between zero and one for each
  %%cell individually
    [rmx,t]=max(cell_rok(cell_index).mean);
    %[rmn,t]=min(cell_rok(cell_index).mean);
    
   
    cell_rok(cell_index).mean = cell_rok(cell_index).mean/(rmx) ; 
    cell_rok(cell_index).mean = (2/cell_rok(cell_index).mean(1,1))*cell_rok(cell_index).mean ;

   
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %PART 2 begins
if(cell(cell_index).average_maxima_distance <=15) % this helps us ignore the outliers
      
    if (size(cell_rok(cell_index).mean,1) >=15)
        y=cell_rok(cell_index).mean(1:15,:)';
        x=[1:1:15];
        
        divisor=15; %for area normalizing
        
        p=polyfit(x,y,7);
        f = polyval(p,x);
        
        %%This is the part where yo
y1=2*ones(1,15);
y2=y;
idx = find(y1 - y2 < eps, 1,'last'); %// finding point of intersection of horizontal line and intensity distribution
px = x(idx);
py = y1(idx);  
%
        plot(x/15,y,'o',x/15,f,'-')
        %ylim([0 3]);
    end

    if (size(cell_rok(cell_index).mean,1) <15)
        y=cell_rok(cell_index).mean(:,:)';
        x=[1:1:size(cell_rok(cell_index).mean,1)];
        
        divisor=size(cell_rok(cell_index).mean,1); %for area normalizing
        
        
        p=polyfit(x,y,10);
    
        f = polyval(p,x);

       %%horizontal line intersection part
y1=2*ones(1,size(f,2));
y2=y;
idx = find(y1 - y2 < eps, 1,'last'); %// Index of coordinate in array, last intersection
px = x(idx);
py = y1(idx);
%
       plot(x,y,'o',x,f,'-')
       %ylim([0 3]);
    end
hold on


end %ignoring the outliers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PART 3 
f=f(:,1:px);
trap=trapz(f); - 2*(px-1);
trap=trap/(divisor);   %X axis normalization: basically just between zero and one all values
area = [area trap];

end

k=waitforbuttonpress;
hold off;


%%now to plot onto the graph
x=[1:1:cell_number];
y=area;
area_plot=area;
scatter(x,y);

title('Quantifying and Classifying the distribution of Rok within a cell');
ylabel('Metric(Area under the curve');
xlabel('Cell Number');
%ylim([0 3]);

if 0
hy1 = graph2d.constantline(0, 'Color',[1 0 0]);
changedependvar(hy1,'y');


hy2 = graph2d.constantline(0.5, 'Color',[0 0 1]);
changedependvar(hy2,'y');
legend([hy1 hy2],'Concentrated Rok Focus marker','Rok Ring marker');
end

a = [1:1:cell_number]'; b = num2str(a); c = cellstr(b);
dx = 0.01; dy = 0.01 ; % displacement so the text does not overlay the data points
text(x-dx, y+dy, c);

%%
grid on;
grid minor;
end
%END OF CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%










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


%% This script calculates the half life of the Rok Plots to be able to show that the half life increases and hence to be able to say that the Rok is diffused and is not centered anymore like it used to be

%% Here we try and get the Covariance as a function of the distance between maximas(basically we try and see whether the maximas in Pearson corelation correspond to the lag equal to the maximal distance


%%Outputting individual cells into files

%{
load('spn1_70_weighted');

for cell_index=1:cell_number,

A=imread('RokProj_z008_c001.tif');  
A=double(A);
tx = datax{1,1,cell_index}'./res;   %x coordinates of polygon for the cell
ty = datay{1,1,cell_index}'./res;   %y coordinates of polygon for the cell



BW=roipoly(A,tx,ty);        %BW is binary mask for the cell
    BW=double(BW);              %Converting to double for higher precision
    SE = strel('octagon',3);    %Edge erosion structure to ignore edge aberrations 
    BW = imerode(BW,SE);        %Eroding the edges using the SE octagonal erosion structure
    ANS=BW.*A; %Multiply element by element the BW mask to the original image. 
    

ANS=uint8(ANS);
%imwrite(M,strcat('cell',num2str(cell_index),'_time',num2str(t),'.tif'));
%jet, hot,

imwrite(ANS,strcat('cell_color_',num2str(cell_index),'.tif'));

end


soline_ring=[96,100,3,4,13,24,26,29,38,39,41,43,44,47,52,63,65,68,70,71,73,74,76,82,84,85,86,87,88,89,102,103,104];
soline_focus=[79,49,2,6,7,9,14,15,19,21,23,28,31,32,35,45,49,50,58,60,61,62,64,78,79,80,81,83,90,95,101,106];
soline_diffused=[16,1,8,10,12,17,18,20,22,25,27,30,33,34,37,40,42,46,53,54,55,56,57,59,66,67,69,72,75,77,91,92,93,94,97,98,99,105,107,108,109,111,112];
%%
%Ignore the initial comments; this script has the metric!

min(area(soline_ring))

min=10;
for i=1:size(soline_ring),
   if(area(soline_ring(i))<min & area(soline_ring(i))~=0) 
    min=area(soline_ring(i));
    min_ind=i;
   end 
end
 %%
 %}
%load('cont4_95');

