function [E_Img]   =  WNNM_DeNoising( N_Img, O_Img, Par )


E_Img           = N_Img;                                                        % Estimated Image
[Height Width]  = size(E_Img);   
TotalPatNum     = (Height-Par.patsize+1)*(Width-Par.patsize+1);                 %Total Patch Number in the image
Dim             = Par.patsize*Par.patsize;  


[Neighbor_arr Num_arr Self_arr] =	NeighborIndex(N_Img, Par);                  % PreCompute the all the patch index in the searching window 
            NL_mat              =   zeros(Par.patnum,length(Num_arr));          % NL Patch index matrix
            CurPat              =	zeros( Dim, TotalPatNum );
            Sigma_arr           =   zeros( 1, TotalPatNum);            
            EPat                =   zeros( size(CurPat) );     
            W                   =   zeros( size(CurPat) );          
    
     ps=10*log10((mean2(E_Img)/std2(E_Img))^2);
     ss =  cal_ssim( O_Img,E_Img,0,0 );
     SNR=(mean2(E_Img))^2/(std2(E_Img))^2;
     cors=SNR;
     corrs=ss;
     
for iter = 1 : Par.Iter 
    img=E_Img;
    delta=I(E_Img);
    E_Img             	=	E_Img + delta.*(N_Img - E_Img);
    [CurPat Sigma_arr]	=	Im2Patch( E_Img, N_Img, Par );                      % image to patch and estimate local noise variance            
    
    if (mod(iter-1,Par.Innerloop)==0)
        Par.patnum = Par.patnum-10;                                             % Lower Noise level, less NL patches
        NL_mat  =  Block_matching(CurPat, Par, Neighbor_arr, Num_arr, Self_arr);% Caculate Non-local similar patches for each 
        if(iter==1)
            Sigma_arr = Par.nSig * ones(size(Sigma_arr));                       % First Iteration use the input noise parameter
        end
    end       

     [EPat, W]  =  PatEstimation( NL_mat, Self_arr, Sigma_arr, CurPat, Par, N_Img ); 
     E_Img      =  Patch2Im( EPat, W, Par.patsize, Height, Width ); 
     

     ps=10*log10((mean2(E_Img)/std2(E_Img))^2);
     SNR=(mean2(E_Img))^2/(std2(E_Img))^2;
     ss =  cal_ssim( O_Img,E_Img,0,0 );
     cor=SNR;
     corr=ss;
     if corr<=corrs | cor<=cors
         E_Img  =  img;
         break;
     else
         corrs=corr;
         cors=cor;
     end
     
     PSNR  = csnr( O_Img, E_Img, 0, 0 );    
    fprintf( 'Iter = %2.3f, PSNR = %.4f \n', iter, PSNR );
    fprintf( 'Iter = %2.3f, SSIM = %.5f \n', iter, ss );
     fprintf( 'Iter = %2.3f, SNR = %.5f \n', iter, SNR );
      fprintf( 'Iter = %2.3f, PS = %.4f \n', iter, ps );
end
return;


