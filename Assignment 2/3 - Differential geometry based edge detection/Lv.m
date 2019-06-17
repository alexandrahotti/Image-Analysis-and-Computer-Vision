function grad_mag = Lv(pic, scale, shape)

if (nargin < 2)
shape = 'same';
end

dxmask =[-0.5 0 0.5];
dymask = dxmask';

if (nargin ==3)
    pic = discgaussfft(pic, scale);
end

Lx = filter2(dxmask, pic, shape);
Ly = filter2(dymask, pic, shape);

grad_mag = Lx.^2 + Ly.^2;
end

