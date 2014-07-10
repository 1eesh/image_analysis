load('spn1_70_weighted');
cell_index= 111;

tx = datax{1,1,cell_index}'./res;   %x coordinates of polygon for the cell
ty = datay{1,1,cell_index}'./res;   %y coordinates of polygon for the cell


imshow(cell(cell_index).ANS)
hold on;

    plot(cell(cell_index).COM_X, cell(cell_index).COM_Y, 'rx');

   text( cell(cell_index).COM_X, cell(cell_index).COM_Y, [num2str(cell_index)],'Color', 'g');   

    h = patch(tx,ty,'g');
    set(h,'FaceColor','None');
    set(h,'edgecolor','magenta');

    
%imcrop(gca);
