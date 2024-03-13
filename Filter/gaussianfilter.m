function I3 = gaussianfilter(I,r, sigma)

[row, col, channel] = size(I);

I1 = padarray(I, [r r], 'replicate','both');
I1(r+1:r+row, r+1:r+col) = I;
I2 = zeros(2*r+row, 2*r+col);


gaussianweight = exp(-([-r:r]).^2/(2*sigma^2));

[xx,yy] = meshgrid(-r:r,-r:r);
weightsum = sum(sum(exp(-(xx.^2 + yy.^2)/(2*sigma^2))));

temp = conv2(1, gaussianweight,I1);
I2 = temp(:,r+1:2*r+col+r);

temp1 = conv2(gaussianweight.',1,I2);
I3 = temp1(2*r+1:2*r+row,r+1:r+col);
I3 = I3/weightsum;
