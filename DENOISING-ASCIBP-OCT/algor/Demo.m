  
    nSig  = 50;
    O_Img = double(imread('12\average.tif'));
    N_Img = double(imread('12\test.tif'));


%     O_Img = double(imread('J.bmp'));
%     N_Img = double(imread('J.png'));
%     average=mean2(N_Img);
%     randn('seed', 0);
%     N_Img = O_Img + nSig* randn(size(O_Img));                                   %Generate noisy image
    PSNR  =  csnr( N_Img, O_Img, 0, 0 );
    fprintf( 'Noisy Image: nSig = %2.3f, PSNR = %.4f \n\n\n', nSig, PSNR );
 
    Par   = ParSet(nSig);
    E_Img = WNNM_DeNoising( N_Img, O_Img, Par); 
    PSNR  = csnr( O_Img, E_Img, 0, 0 );
    
    fprintf( 'Estimated Image: nSig = %2.3f, PSNR = %2.2f \n\n\n', nSig, PSNR );
    figure,imshow(uint8(E_Img));                            
    psnr_noise=20*log10(255/sqrt(mean((E_Img(:)-O_Img(:)).^2)))
    ssim  =  cal_ssim( O_Img,E_Img,0,0 )
   snr=10*log10((mean2(E_Img)/std2(E_Img))^2)