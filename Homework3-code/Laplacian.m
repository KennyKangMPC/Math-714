function [Lap] = Laplacian(vec)
%Laplacian: takes the laplacian of the input vector vec.
%The code is developed based on Trefethen Spectral Methods p20.m

N = size(vec,1) - 1;
uxx = zeros(N+1,N+1); uyy = zeros(N+1,N+1);
for i = 2:N % 2nd derivs wrt x in each row
    v = vec(i,:); 
    w = chebfft(v');
    w2 = chebfft(w);
    uxx(i,:) = w2';
end
for j = 2:N % 2nd derivs wrt y in each column
    v = vec(:,j); 
    w = chebfft(v);
    w2 = chebfft(w);
    uyy(:,j) = w2;
end
Lap = uxx + uyy;
end