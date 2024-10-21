function [ EPat W ] = PatEstimation( NL_mat, Self_arr, Sigma_arr, CurPat, Par,N_Img)
        img1 = N_Img;
        EPat = zeros(size(CurPat));
        W    = zeros(size(CurPat));
        for  i      =  1 : length(Self_arr)                                 % For each keypatch group
            Temp    =   CurPat(:, NL_mat(1:Par.patnum,i)); 
       
           Temp = double(Temp); 
            TE      =   sort((Temp(:,1)));

            avgEntropy = mean2(entropy(img1));
            stdc = std((img1));
            rows1 = size(img1, 2);
            patd = Par.patsize / rows1;
            k = 0.8;
           entropy_threshold = avgEntropy * ( 1 - (k *(1 - exp(-stdc-patd)) / (1 + exp(-patd-stdc))))/100;

            variance_threshold = var(TE(:)) - 1;

            
            entropy_value = entropy(TE);
            variance_value = var(TE(:));


            M_Temp  =   repmat(mean( Temp, 2 ),1,Par.patnum);
            Temp    =   Temp-M_Temp;

            if entropy_value > entropy_threshold && variance_value > variance_threshold
               E_Temp 	=  WNNMs( Temp,Sigma_arr(Self_arr(i)),M_Temp, Par);

            else
               E_Temp 	=   WNNM( Temp, Par.d, Sigma_arr(Self_arr(i)), M_Temp, Par.ReWeiIter);
            end

            EPat(:,NL_mat(1:Par.patnum,i))  = EPat(:,NL_mat(1:Par.patnum,i))+E_Temp;      
            W(:,NL_mat(1:Par.patnum,i))     = W(:,NL_mat(1:Par.patnum,i))+ones(Par.patsize*Par.patsize,size(NL_mat(1:Par.patnum,i),1));
        end
end

