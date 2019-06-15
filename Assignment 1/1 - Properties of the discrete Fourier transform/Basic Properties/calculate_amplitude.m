function amplitude = calculate_amplitude(Fhat, sz)

amplitude = max(Fhat(:))/sz^2;
end