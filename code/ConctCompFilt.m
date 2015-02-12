function component_f=ConctCompFilt(component)
[M N]=size(component{1});
component_f=false(M,N);
numberOfObj=length(component);
for n=1:numberOfObj
    [row,col]=find(component{n});
    r_max=max(row); r_min=min(row); c_max=max(col); c_min=min(col);
    if((r_max-r_min+1)/M>0.3 || (c_max-c_min+1)/N>0.3)
        component_f=component_f+component{n};
    end
end
end