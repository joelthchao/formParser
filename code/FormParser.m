function FormParser(imageFileName,docFileName)
delete(docFileName);
result_preprocess='result_preprocess';
preprocess(imageFileName,result_preprocess);
result_LineExt=LineExtraction(result_preprocess);
result_CellExt=CellExtraction(result_LineExt,result_preprocess);
cellList=cell(result_CellExt{2},4);
cellList(:,1:3)=result_CellExt{1};
for c=1:result_CellExt{2}
    cellList{c,4}=OCR(cellList{c,3});
end
DataCell_v=cellList(:,4);
DataCell=cell(result_LineExt{5}-1,result_LineExt{6}-1);
for h=1:result_LineExt{5}-1
    DataCell(h,:)=DataCell_v(...
        (h-1)*(result_LineExt{6}-1)+1:h*(result_LineExt{6}-1)).';
end
%{
DataCell=vec2mat(DataCell,result_LineExt{5}-1);
DataCell=DataCell.';
%}
writeWordForm(docFileName,DataCell);
end