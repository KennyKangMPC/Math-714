function f = init(x)
    % This is the IC function for x, same for y. (Replace x by y)
    f = exp(-400.*(x-0.5).^2);
end
