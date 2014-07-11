%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%master.m (the first script that you would call when you start analysing

%%USEFUL OUTPUT VARIABLES

%%cell_rok is the structure containing all the relevant information for Rok
%%cell_myosin is the structure containing all the relevant information for Rok


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%














%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LOADING DATA AND CHANGING PATHS

clear all;      %clears the current variables in the workspace
res=0.1417;      %set the resolution for the image.This is determined by the microscopes, it is 0.2125 if you have 0.2125 microns per pixel, 0.1417 for spn,0.106 for wt
threshold=0.45; %Set the threshold for segmentation that we will use in our Center of mass algorithm(0.8 means , 80% of maximum intensity is considered
edge_erosion=3;%Set the number of pixels that you would like to shave off the edge   
rok=1;          %Flag to recognize when to plot rok and when to plot myosin


%%Loading the data for the Vertices
load('/Users/eesh/Desktop/image_analysis/Membranes--vertices--Vertex-x.mat');
datax=data; %save the data loaded into a variable
cell_number=size(datax,3); % This just assigns 109 to the cel_number for the given file
load('/Users/eesh/Desktop/image_analysis/Membranes--vertices--Vertex-y.mat'); %this loads the y 
datay=data; %save the data loaded into a variable


cell_number=size(datay,3); %Count the number of cells in the image(by looking at size of EDGE DATA)
COM=zeros(cell_number,2);  %Initializing Center of Mass(COM) to all zeros

%%Loading the images into MATLAB variables
A=imread('RokProj_z008_c001.tif');          %Load the Rok Image into A
M=imread('MBSProj_z008_c002.tif');          %Load the MBS data into M
Q=imread('MyosinProj_z008_c003.tif');       %Load the Myosin data into Q
%C=imread('CellsProj_z008_c003.tif');        %Load the Membrane data into C


imshow(A);                                  %Displays the image A(Rok)
hold on;
A_hold=A;                                   %Save the original uint8 Rok image into A_hold(enables imshow(A_hold)

%%Converting all variables to a double
A=double(A);                                %Converts A to double for computation
M=double(M);
Q=double(Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Loop over all the cells in the image and find the center of mass of each.
%I call various scripts in this program and I specifically mark the
%location of each script with a line of stars. The address needs to change
%depending on where you execute the scripts.

for cell_index=1:cell_number, 
    

    
%*************************************************************************%     
    %%SCRIPT TO FIND CENTER OF MASS OF A CELL 
    run('/Users/eesh/Desktop/image_analysis/centerofmass_cell');
%*************************************************************************% 
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This section plots the center of mass onto the image for visual inspection
    plot(COM_X, COM_Y, 'rx');
    h = fill(tx,ty,'r');
    set(h,'FaceColor','None');
    COM;
    hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
  
%*************************************************************************% 
    %%SCRIPT TO FIND THE RADIAL INTENSITY DISTRIBUTION FOR ROK
    run('/Users/eesh/Desktop/image_analysis/radial_distribution.m');
%*************************************************************************% 


    %%The following line plots text number onto the cell image(for visual
    %%inspection)
    text( cell(cell_index).COM_X, cell(cell_index).COM_Y, [num2str(cell_index)],'Color', 'g');   
    
end


cell_rok=cell;  %%SAVING ALL THE DATA for ROK into cell_rok structure for future use



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%This section does the exact same things for MYOSIN
% 
A=Q;   %This assigns the Myosin image matrix to the primary working variable in all scripts which is A
rok=0; %Here we change the rok flag to 0(as we are now talking about myosin(Basically, this flag justs assigns color to protein 1 and protein 2 (red and green)   
%


for cell_index=1:cell_number,

  %*************************************************************************% 
    %%SCRIPT TO FIND THE RADIAL INTENSITY DISTRIBUTION FOR ROK  
    run('/Users/eesh/Desktop/image_analysis/radial_distribution.m');
  %*************************************************************************%
end
cell_myosin=cell;   %%SAVING ALL THE DATA for Myosin into cell_myosin structure for future use


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%The processing of the information here is essentially done. We just save
%%the whole workspace into whatever variable we want to save it in using:

%%uncomment and add variable name here.

%save 'variable_name'













