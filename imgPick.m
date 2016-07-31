function imgOut = imgPick(imgOrig,imgStack,steps,pick)

	[nx ny colors] = size(imgOrig);
	
	 if colors == 1
		imgOut = reshape(imgStack(pick,:),nx,ny);
	else
		red = imgStack(1:steps,:);
		grn = imgStack(1+steps:2*steps,:);
		blu = imgStack(1+2*steps:3*steps,:);
		imgOut = zeros(nx,ny,colors);
		imgOut(:,:,1) = reshape(red(pick,:),nx,ny); 
		imgOut(:,:,2) = reshape(grn(pick,:),nx,ny); 
		imgOut(:,:,3) = reshape(blu(pick,:),nx,ny);
	end

end