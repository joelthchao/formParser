function writeWordForm(WordFileName,DataCell)
CurDir=pwd;
FileSpec = fullfile(CurDir,WordFileName);
[ActXWord,WordHandle]=StartWord(FileSpec);
Style='Heading 2';
TextString='Generating Form from MATLAB';
WordText(ActXWord,TextString,Style,[0,1]);%enter after text
%{
DataCell={'Test 1', num2str(0.3) ,'Pass';
          'Test 2', num2str(1.8) ,'Fail'};
%}
[NoRows,NoCols]=size(DataCell);          
%create table with data from DataCell
WordCreateTable(ActXWord,NoRows,NoCols,DataCell,1);%enter before table
CloseWord(ActXWord,WordHandle,FileSpec);
return

function WordCreateTable(actx_word_p,nr_rows_p,nr_cols_p,data_cell_p,enter_p) 
    %Add a table which auto fits cell's size to contents
    if(enter_p(1))
        actx_word_p.Selection.TypeParagraph; %enter
    end
    %create the table
    %Add = handle Add(handle, handle, int32, int32, Variant(Optional))
    actx_word_p.ActiveDocument.Tables.Add(actx_word_p.Selection.Range,nr_rows_p,nr_cols_p,1,1);
    %Hard-coded optionals                     
    %first 1 same as DefaultTableBehavior:=wdWord9TableBehavior
    %last  1 same as AutoFitBehavior:= wdAutoFitContent
     
    %write the data into the table
    for r=1:nr_rows_p
        for c=1:nr_cols_p
            %write data into current cell
            WordText(actx_word_p,data_cell_p{r,c},'Normal',[0,0]);
            
            if(r*c==nr_rows_p*nr_cols_p)
                %we are done, leave the table
                actx_word_p.Selection.MoveDown;
            else%move on to next cell 
                actx_word_p.Selection.MoveRight;
            end            
        end
    end
return

function [actx_word,word_handle]=StartWord(word_file_p)
    % Start an ActiveX session with Word:
    actx_word = actxserver('Word.Application');
    actx_word.Visible = true;
    trace(actx_word.Visible);  
    if ~exist(word_file_p,'file');
        % Create new document:
        word_handle = invoke(actx_word.Documents,'Add');
    else
        % Open existing document:
        word_handle = invoke(actx_word.Documents,'Open',word_file_p);
    end           
return

function WordText(actx_word_p,text_p,style_p,enters_p,color_p)
	%VB Macro
	%Selection.TypeText Text:="Test!"
	%in Matlab
	%set(word.Selection,'Text','test');
	%this also works
	%word.Selection.TypeText('This is a test');    
    if(enters_p(1))
        actx_word_p.Selection.TypeParagraph; %enter
    end
	%actx_word_p.Selection.Style = style_p;
    if(nargin == 5)%check to see if color_p is defined
        actx_word_p.Selection.Font.Color=color_p;     
    end
    
	actx_word_p.Selection.TypeText(text_p);
    actx_word_p.Selection.Font.Color='wdColorAutomatic';%set back to default color
    for k=1:enters_p(2)    
        actx_word_p.Selection.TypeParagraph; %enter
    end
return

function CloseWord(actx_word_p,word_handle_p,word_file_p)
    if ~exist(word_file_p,'file')
        % Save file as new:
        invoke(word_handle_p,'SaveAs',word_file_p,1);
    else
        % Save existing file:
        invoke(word_handle_p,'Save');
    end
    % Close the word window:
    invoke(word_handle_p,'Close');            
    % Quit MS Word
    invoke(actx_word_p,'Quit');            
    % Close Word and terminate ActiveX:
    delete(actx_word_p);            
return