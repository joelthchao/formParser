function [prof_peak prof_peakpt numPeak]=ProjProf(prof)
L=length(prof);
prof_sort=sort(prof,'descend');
prof_sorts=smooth(prof_sort,9);
prof_diff=diff(prof_sorts);
prof_diffs=smooth(prof_diff,9);
prof_diffs=prof_diffs(11:L-1);
index_h=find(prof_diffs>-0.5,1);
thresh_h=prof_sorts(index_h);
prof_peak=(prof>thresh_h);
prof_peakpt=bwmorph(prof_peak,'shrink',Inf);
numPeak=sum(prof_peakpt);
end