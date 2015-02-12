function result=CellExtraction(result_LineExtraction,input_file)
horLine=result_LineExtraction{1};
verLine=result_LineExtraction{2};
horLineForm=result_LineExtraction{3};
verLineForm=result_LineExtraction{4};
numHor=result_LineExtraction{5};
numVer=result_LineExtraction{6};
Im_range=imread(input_file);

vtxList=true(numHor-1, numVer-1);
cellList=cell((numHor-1)*(numVer-1),3);
% 1st col: upper-left vtx, 2nd col: lower-right vtx, 3rd col: cell content
numCell=0;
while(sum(vtxList(:))>0)
    [row_1 col_1]=find(vtxList,1);
    numCell=numCell+1;
    cellList{numCell,1}=[row_1 col_1];
    row_2=row_1+1;col_2=col_1+1;
    while(row_2<numHor)
        if(horLineForm(row_2,col_2-1))
            break;
        else
            row_2=row_2+1;
        end
    end
    while(col_2<numVer)
        if(verLineForm(row_2-1,col_2))
            break;
        else
            col_2=col_2+1;
        end
    end
    cellList{numCell,2}=[row_2 col_2];
    vtxList(row_1:row_2-1,col_1:col_2-1)=0;
end
cellList=cellList(1:numCell,:);

%%%%% Draw Result %%%%%
hold on;
for c=1:numCell
    plot((verLine(cellList{c,1}(2),3)+verLine(cellList{c,2}(2),3))/2,...
         (horLine(cellList{c,1}(1),3)+horLine(cellList{c,2}(1),3))/2,...
         'cs','MarkerSize',20);
end
hold off;

for c=1:numCell
    cellList{c,3}=Im_range(...
        horLine(cellList{c,1}(1),2):horLine(cellList{c,2}(1),1),...
        verLine(cellList{c,1}(2),2):verLine(cellList{c,2}(2),1));
end
result={cellList numCell};
end