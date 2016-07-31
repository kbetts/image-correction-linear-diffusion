function [imgSoln,imgTS,imgTSF] = filter(imgOrig,sigma,filterType)
	%% Kellen Betts  |  kellen.betts@gmail.com
	%% Date:  120214  |  Version  1.0
	%% Description: 	Function that implements linear filters (Gaussian and Shannon) for image processing.

	[h w d] = size(imgOrig);
	imgSoln = zeros(h,w,d);

	for j=1:d
	
		img = imgOrig(:,:,j);

		imgT = fft2(img);
		imgTS = fftshift(imgT);

		kx = 1:w;
		ky = 1:h;
		[Kx,Ky] = meshgrid(kx,ky);
		
		a = ceil(w/2);
		b = ceil(h/2);
		
		switch filterType	
		case 'gaussian'
			F = exp(-sigma*(Kx-a).^2 - sigma*(Ky-b).^2);
		case 'shannon'
			width = 50;
			F = zeros(h,w);
			F(b-width:1:b+width,a-width:1:a+width) = 1;
		end
	
		if length(sigma) > 1
			n = length(sigma);
			figure(1), subplot(floor(n/2),3,1), imshow(uint8(img)), colormap(gray);
			title('Original');
			for k=1:n
				imgTSF = imgTS.*F;
				imgF = ifft2(ifftshift(imgTSF));
				figure(1), subplot(floor(n/2),3,k+1), imshow(uint8(real(imgF)));
				title(strcat('Filter (\sigma=',num2str(sigma(k)),')'));
			end
		else
			imgTSF = imgTS.*F;
			imgF = real(ifft2(ifftshift(imgTSF)));
		end
	
		imgSoln(:,:,j) = imgF;
	
	end

end