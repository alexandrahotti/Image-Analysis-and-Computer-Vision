function pixels = Lv(pic, shape)

if (nargin < 2)
    shape = 'same';
end
dxmask =[-0.5 0 0.5];
dymask=dxmask';
Lx = filter2(dxmask, pic, shape);
Ly = filter2(dymask, pic, shape);

pixels = Lx.^2 + Ly.^2; %sqrt!
end

