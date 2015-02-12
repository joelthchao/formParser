function result=preprocess(input_file, output_file)
%read file
color_img = imread(input_file);
gray_img = rgb2gray(color_img);
gray_img = imresize(gray_img, 0.2);
imshow(gray_img, 'border', 'tight')

%image size
[x_size, y_size] = size(gray_img);

%local histogram equalization
window_size = 41;
his_img = zeros(x_size, y_size);

for x = 1:x_size
    for y = 1:y_size
        if (mod(x,10) == 1 && y == 1)
            fprintf('%d\n', round(x/x_size*100))
        end
        histogram = zeros(1,256);
        
        for i = x-(window_size-1)/2:x+(window_size-1)/2
            for j = y-(window_size-1)/2:y+(window_size-1)/2
                if (i < 1 || i > x_size || j < 1 || j > y_size)
                    continue;
                end
                histogram(1,gray_img(i,j)) = histogram(1,gray_img(i,j)) + 1;
            end            
        end        
        v = gray_img(x,y);  
        new_v = sum(histogram(1:v));
        new_v = new_v*256/(window_size*window_size);
        his_img(x,y) = new_v;
    end
end

his_img = uint8(his_img);
figure, imshow(his_img, 'border', 'tight')

%Binarization
bin_img = im2bw(his_img, 0.1);
final_img = bwareaopen(~bin_img, 50);
final_img = ~final_img;
figure, imshow(final_img, 'border', 'tight')

%Save image
%fid=fopen(output_file,'w');
%fwrite(fid,final_img'); fclose(fid);
imwrite(final_img,output_file, 'jpg')
result = 'finish';
end