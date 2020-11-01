N = 0;
dif = 9999;
xq = 0:0.0018:1;
while dif > 0.01
    N = N+1;
    x = linspace(0,1,N+1);
    v = exp(-400*(x-0.5).^2);
    vq = interp1(x,v,xq);
    f = exp(-400*(xq-0.5).^2);
    dif = norm(f-vq,Inf);
end
disp(['The smallest value of N = ', num2str(N)]);
