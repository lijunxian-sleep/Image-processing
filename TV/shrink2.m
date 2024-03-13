function [xs,ys] = shrink2(x,y,lambda)
s = max( sqrt(sum(x.^2 + y.^2,3)),1e-6);
s = repmat(s,[1,1,size(x,3)]);
xs = max(0, s-lambda).*x./s;
ys = max(0, s-lambda).*y./s;
end