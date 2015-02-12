function result=LineExtraction(input_file)
%%%%% File Reading %%%%%
Im_range=imread(input_file);
[M N]=size(Im_range);
%im=rgb2gray(im_col);
Im=(Im_range<(max(Im_range(:))/2));
width=0;
while(1)
    Im_new=bwmorph(Im,'erode');
    if(Im_new==Im) break; end
    width=width+1;
    Im=Im_new;
end

%%%%% Edge Detection %%%%%
%'sobel','prewitt','roberts','log','zerocross','canny'
Im_edge=edge(Im_range,'zerocross');
Im=bwmorph(Im_edge,'dilate',ceil(width/2)+1);
Im=bwmorph(Im,'erode',ceil(width/2));

%%%%% Connected Component Generation %%%%%
component=ConctCompLab(Im);

%%%%% Connected Component Filtering %%%%%
Im=ConctCompFilt(component);

Im=bwmorph(Im,'bridge',Inf);
Im=bwmorph(Im,'dilate',2);
Im=bwmorph(Im,'erode',3);

%%%%% Projection Profile %%%%%
hor=sum(Im.'); % horizontal profile->vertical line
ver=sum(Im); % vertical profile->horizontal line

[hor_peak hor_peakpt numHor]=ProjProf(hor);
[ver_peak ver_peakpt numVer]=ProjProf(ver);
%{
hor_sort=sort(hor,'descend');
hor_sorts=smooth(hor_sort,9);
hor_diff=diff(hor_sorts);
hor_diffs=smooth(hor_diff,9);
hor_diffs=hor_diffs(11:M-1);
index_h=find(hor_diffs>-0.5,1);
thresh_h=hor_sorts(index_h);
hor_peak=(hor>thresh_h);
hor_peakpt=bwmorph(hor_peak,'shrink',Inf);
numHor=sum(hor_peakpt);

ver_sort=sort(ver,'descend');
ver_sorts=smooth(ver_sort,9);
ver_diff=diff(ver_sorts);
ver_diffs=smooth(ver_diff,9);
ver_diffs=ver_diffs(11:N-1);
index_v=find(ver_diffs>-0.5,1);
thresh_v=ver_sorts(index_v);
ver_peak=(ver>thresh_v);
ver_peakpt=bwmorph(ver_peak,'shrink',Inf);
numVer=sum(ver_peakpt);
%}

% Horizontal Lines
% 1st col: upper boundary, 2nd col: lower boundary, 3rd col: peak
horLine=zeros(numHor,3);
for m=1:numHor
    horLine(m,3)=find(hor_peakpt,1);
    hor_peakpt(horLine(m,3))=0;
    horLine(m,1)=find(hor_peak,1);
    rightBound=horLine(m,1);
    while(hor_peak(rightBound)~=0)
        rightBound=rightBound+1;
    end
    horLine(m,2)=rightBound-1;
    hor_peak(horLine(m,1):horLine(m,2))=...
        zeros(1,horLine(m,2)-horLine(m,1)+1);
end

% Vertical Lines
% 1st col: left boundary, 2nd col: right boundary, 3rd col: peak
verLine=zeros(numVer,3);
for n=1:numVer
    verLine(n,3)=find(ver_peakpt,1);
    ver_peakpt(verLine(n,3))=0;
    verLine(n,1)=find(ver_peak,1);
    rightBound=verLine(n,1);
    while(ver_peak(rightBound)~=0)
        rightBound=rightBound+1;
    end
    verLine(n,2)=rightBound-1;
    ver_peak(verLine(n,1):verLine(n,2))=...
        zeros(1,verLine(n,2)-verLine(n,1)+1);
end

%%%%% Line Detection %%%%%
horLineForm=false(numHor,numVer-1); % true if there's a line
verLineForm=false(numHor-1,numVer);
% Vertical line detection
for m=1:numHor-1
    [peak peakpt numPeak]=ProjProf2(sum(Im(horLine(m,2)+1:horLine(m+1,3)-1,:)));
    for n=1:numVer
        if(n==1)
            leftBound=1;
        else
            leftBound=round((verLine(n-1,2)+verLine(n,1))/2);
        end
        if(n==numVer)
            rightBound=N;
        else
            rightBound=round((verLine(n,2)+verLine(n+1,1))/2);
        end
        if(sum(peakpt(leftBound:rightBound))>0) verLineForm(m,n)=1; end
    end
end
% Horizontal line detection
for n=1:numVer-1
    [peak peakpt numPeak]=ProjProf2(sum(Im(:,verLine(n,2)+1:verLine(n+1,3)-1).'));
    for m=1:numHor
        if(m==1)
            upperBound=1;
        else
            upperBound=round((horLine(m-1,2)+horLine(m,1))/2);
        end
        if(m==numHor)
            lowerBound=M;
        else
            lowerBound=round((horLine(m,2)+horLine(m+1,1))/2);
        end
        if(sum(peakpt(upperBound:lowerBound))>0) horLineForm(m,n)=1; end
    end
end

%%%%% Draw Result %%%%%
figure,imshow(Im,'border','tight');
hold on;
for m=1:numHor
    for n=1:numVer
        plot(verLine(n,3),horLine(m,3),'ro','MarkerSize',12);
        % Draw vertical line
        if(m~=numHor && verLineForm(m,n))
            line([verLine(n,1) verLine(n,1)],[horLine(m,2) horLine(m+1,1)],...
                'Color','m','LineWidth',2);
            line([verLine(n,2) verLine(n,2)],[horLine(m,2) horLine(m+1,1)],...
                'Color','m','LineWidth',2);
        end
        % Draw horizontal line
        if(n~=numVer && horLineForm(m,n))
            line([verLine(n,2) verLine(n+1,1)],[horLine(m,1) horLine(m,1)],...
                'Color','m','LineWidth',2);
            line([verLine(n,2) verLine(n+1,1)],[horLine(m,2) horLine(m,2)],...
                'Color','m','LineWidth',2);
        end
    end
end
hold off;
result={horLine verLine horLineForm verLineForm numHor numVer};
end
