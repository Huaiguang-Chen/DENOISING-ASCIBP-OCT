function result = snr(image,sigma)
% peak signal to noise ratio; image: amplitude data, sigma: 
% noise standard deviation.
% by shujun fu, 08/20/2015.
sigma=std2(E_Img);
result = 20*log10(max2(image)/sigma);

