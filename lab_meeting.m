load('cont3_95');

%%
 for cell_index= 47;

tx = datax{1,1,cell_index}'./res;   %x coordinates of polygon for the cell
ty = datay{1,1,cell_index}'./res;   %y coordinates of polygon for the cell


imshow(cell(cell_index).ANS)
hold on;

    plot(cell(cell_index).COM_X, cell(cell_index).COM_Y, 'rx');

   text( cell(cell_index).COM_X, cell(cell_index).COM_Y, [num2str(cell_index)],'Color', 'g');   
hold on;
    h = patch(tx,ty,'g');
    set(h,'FaceColor','None');
    set(h,'edgecolor','magenta');

    
saveas(gca,strcat(num2str(cell_index),'.eps'))

end
%%
load('cont3_95');

imshow(A_hold);
hold on;
for cell_index=1:cell_number,

    tx = datax{1,1,cell_index}'./res;   %x coordinates of polygon for the cell
ty = datay{1,1,cell_index}'./res;   %y coordinates of polygon for the cell

        plot(cell(cell_index).COM_X, cell(cell_index).COM_Y, 'mx');
h = fill(tx,ty,'r');
    set(h,'FaceColor','None');
       text( cell(cell_index).COM_X, cell(cell_index).COM_Y, [num2str(cell_index)],'Color', 'g');   

    
end


%%