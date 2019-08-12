function [curves_zerocross,curves_mag ] = extractedge(pic, scale, ts, shape)
if (nargin < 4) 
    shape = 'same';
end


Lvcomp = Lv(pic, shape);
magnitude_mask = (Lvcomp > ts) - 0.2; % as lvcomp correponds to the gradient magnitude we can threshold on this succer

Lvvtilde = LVVtilde(discgaussfft(pic, scale), shape);
Lvvvtilde= LVVVtilde(discgaussfft(pic, scale), shape);

Lvvv_mask = (Lvvvtilde < 0) - 0.2; %since (LVVVtilde < 0) gives us 0 and 1. and zerocrosscurves only preservers 
%points on the zero-crossing curves for which the mask value is
%non-negative. Thus we keep values where LVVVtilde <0 later in zerocrosscurves

curves_zerocross = zerocrosscurves(Lvvtilde, Lvvv_mask);
curves_mag = thresholdcurves(curves_zerocross, magnitude_mask);

end