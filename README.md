The descriptions of source code and testing data is as follows:


Source code: 

Demo.m: This code demonstrates the application of the improved algorithm for image denoising. The code reads two images, applied the algorithm to the noisy image using the set parameters, generating a denoised image. And it evaluates the effectiveness of the denoising by calculating Psnr Snr and Ssim. And it displays the denoised image.

WNNM_DeNoising.m: This code is the main program of the proposed denoising algorithm. It initializes the relevant variables and preprocesses the patches. This code performs iterative denoising by calling other functions. And it sets criteria for termination of the iteration

ParSet.m: This code Contains several parameter settings related to the image denoising algorithm.

NeighborIndex.m: This function precompute the all the patch indexes in the Searching window. Neighbor_arr is the array of neighbor patch indexes for each keypatch. Num_arr is array of the effective neighbor patch numbers for each keypatch. SelfIndex_arr is the index of keypatches in the total patch index array.

Localamplification.m:

Block_matching.m: The function is designed to find the block that is most similar to a specific block in the input patch using chi-square distance.

I.m: This function calculates the backward projection iteration operation δ adaptively by extracting the image characteristics.

Patch2Im.m: This function recombines image blocks and weights into a complete image
Im2Patch.m:
PatEstimation.m: This function selects different denoising methods by caculating image entropy and variance of the input image and updates the corresponding image information.

WNNM.m: This function uses soft threshold to shrink singular values of the flat blocks specified by dynamic classification selecting rule.

WNNMs.m: This function uses improved threshold to shrink singular values of the structural blocks specified by dynamic classification selecting rule.

thre.m: This function is the improved function introduced two regulatory factors and segments singular values to shrink.

soft.m: This function defines the soft threshold function, which is used above.

ClosedWNNM.m: This function is the step of using the soft threshold to shrink. It calculates and processes the singular values decomposed.

CalculateWei.m: This function aims to calculate the weight values for image restore weighting operations.

cal_ssim.m: This is an implementation of the algorithm for calculating the Structural Similarity (SSIM) index between two images.

snr.m: This function calculates the signal to noise ratio index between two images.

csnr.m: This is an implementation of the algorithm for calculating the Peak signal to noise ratio index between two images.


The experiment used 13 OCT images which were provided in literature:[25]Fang, L. et al. Fast acquisition and reconstruction of optical coherence tomography images via sparse representation. IEEE transactions on medical imaging 32,2034–2049 (2013). https://people.duke.edu/~sf59/Fang_TMI_2013.htm.
