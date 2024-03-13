function img = TV_NonblindDeblur(blur, kernel, lambda, mu)
% model: min lambda1*||Du||_1+0.5*||h*u-f||_2^2
% SB：lambda*(||d||_1+mu/2*||Du-d+b||_2^2+0.5*||h*u-f||_2^2)
%blur是模糊图，0~255范围，double类型,lambda是TV项，通常比较小,小于1
% lambda=0.25, mu = 0.05
%if std_n==1; lambda = 0.08; mu = 0.05; end
%if std_n==2.55; lambda = 0.25; mu = 0.05; end
%if std_n==9; lambda = 15; mu = 0.05; end


h = kernel;
% initialization
f = blur; u = f;
dx = 0*f; dy = 0*f; bx = dx; by = dy; 
otfDx = psf2otf([1,-1],size(f));
otfDy = psf2otf([1;-1],size(f));
DTD = abs(otfDx).^2+abs(otfDy).^2;
% parameters
U_old = 0; crit = 1; 
U = U_old;

k=0;    
% 
while crit>1e-5
    k=k+1;
      
    % d,b sub-problem
    [dx, dy] = shrink2(Dx(u)+bx, Dy(u)+by,1/mu);
    bx = bx+Dx(u)-dx;
    by = by+Dy(u)-dy;
    
     % u sub-problem   
    otfH = psf2otf(h,size(f));
    Denom = abs(otfH).^2+lambda.*mu.*DTD;
    Nomin = conj(otfH).*fft2(f)+lambda.*mu.*fft2(Dxt(dx-bx)+Dyt(dy-by));
    FT = Nomin./Denom;
    u = real(ifft2(FT));

       
    U = u;
    crit = norm(U-U_old,'fro')/norm(U,'fro');
%     psnrr = [psnrr psnr(I,U)];
    U_old=U;

end
img = U;
