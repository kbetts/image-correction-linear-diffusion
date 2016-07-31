function plot_filtered(imgOrig,imgSoln,fig)

	[h w d] = size(imgOrig);
	
	for j=1:d

		if d == 1
			colors = ['bw','bw'];
		else
			colors = ['r','g','b'];
		end

		orig = imgOrig(:,:,j);
		soln = imgSoln(:,:,j);

		figure(fig), subplot(d,2,(2*j-1)), imshow(uint8(orig));
		title(strcat('Original (',colors(j),')'));

		figure(fig), subplot(d,2,(2*j)), imshow(uint8(soln));
		title(strcat('Filter (',colors(j),')'));

	end
	
	drawnow;
	
end