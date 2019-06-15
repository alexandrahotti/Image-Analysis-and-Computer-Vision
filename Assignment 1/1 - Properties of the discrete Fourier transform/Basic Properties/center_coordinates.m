function [ vc, uc ] = center_coordinates(u, v, sz)
% Centers cordinates such that they are in the interval [-pi,pi].
% Originally they are in the range [0,2pi].

if (u <= sz/2)
    uc = u - 1; 
else
    uc = u - 1 - sz;
end

if (v <= sz/2)
  vc = v - 1;
else
  vc = v - 1 - sz;
end

end
