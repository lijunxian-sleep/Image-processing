function img = TV_Denoise(img_noise, lambda, mu)

    otfDx = psf2otf([1,-1],size(img_noise));
    otfDy = psf2otf([1;-1],size(img_noise));
    DTD = abs(otfDx).^2+abs(otfDy).^2;
    % 迭代初值和参数设定
    d1 = 0*img_noise; b1 = d1; 
    d2 = d1; b2 = d2;
    u = img_noise;
    
    for iter=1:20
        Nomin = lambda*img_noise + mu*(Dxt(d1-b1)+Dyt(d2-b2));
        Denom = lambda + mu*DTD;
        u = real(ifft2(fft2(Nomin)./Denom));
        
        [d1,d2] = shrink2(Dx(u)+b1,Dy(u)+b2,1./mu);
        b1 = b1+Dx(u)-d1;
        b2 = b2+Dy(u)-d2;
    end
    
    img = u;
end

