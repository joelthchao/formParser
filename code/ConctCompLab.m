function component=ConctCompLab(F)
[M N]=size(F);
list=F;
component={};
while(sum(list(:)))
    G_old=false(M,N);
    [row,col]=find(list,1);
    G_old(row,col)=1;
    G_new=G_old;
    % whiletime=0;
    while(true)
        % whiletime=whiletime+1;
        % fprintf('whiletime = %d\n',whiletime);
        G_new=bwmorph(G_old,'dilate') & F;
        if(all(G_new==G_old)) break; end
        G_old=G_new;
    end
    component=[component;{G_new}];
    list=list-G_new;
end
%{
numberOfObj=length(component);
level=floor(255/(numberOfObj+1));
newmatrix=zeros(M,N);
for n=1:numberOfObj
    newmatrix=newmatrix+n*level*component{n};
end
%}
end