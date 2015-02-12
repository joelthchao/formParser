function result_string=OCR(input_image_matrix)
create_templates();
% Read image
imagen=input_image_matrix;
% Show image
%imshow(imagen);
%title('INPUT IMAGE WITH NOISE')
% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
% Convert to BW
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
%Storage matrix word from image
re=imagen;
%Opens text.txt as file for write
%fid = fopen('text.txt', 'wt');
% Load templates
load templates
global templates
% Compute the number of letters in template file
num_letras=size(templates,2)
result_string = [];
while 1
    %Fcn 'lines' separate lines in text
    [fl re]=lines(re);
    imgn=fl;
    %Uncomment line below to see lines one by one
    %imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
        [r,c] = find(L==n);        
        n1=imgn(min(r):max(r),min(c):max(c));          
        img_r=imresize(n1,[42 24]);        
        %imshow(img_r);pause(0.1)                
        letter=read_letter(img_r,num_letras);        
        result_string=[result_string letter];
    end    
    %fprintf(fid,'%s\n',result_string);%Write 'word' in text file (upper)    
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end
end
%fclose(fid);
%winopen('text.txt')

end