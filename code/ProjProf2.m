function [prof_peak prof_peakpt numPeak]=ProjProf2(prof)
thresh_h=round(max(prof)/2);
prof_peak=(prof>thresh_h);
prof_peakpt=bwmorph(prof_peak,'shrink',Inf);
numPeak=sum(prof_peakpt);
end