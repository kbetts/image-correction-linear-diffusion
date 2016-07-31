function plot_diffSeries(orig,t,uSoln,fig)

	if length(t) ~= 8
		'error... need length(tspan) = 8'
		return;
	end

	[nx ny colors] = size(orig);
	steps = length(t);
	
	rows=3;
	cols=3;

	% plot original in first position
	figure(fig)
	subplot(rows,cols,1), imshow(uint8(orig))
	title('Original');

	% plot each t step
	if colors == 1
		% b&w image
		for j=1:length(t) 
			uPlot = reshape(uSoln(j,:),nx,ny); 
			figure(fig), subplot(rows,cols,j+1), imshow(uint8(uPlot));
			title(strcat('Diffusion (t=',num2str(t(j)),')'));
		end
	else
		% color image
		uR = uSoln(1:steps,:);
		uG = uSoln(1+steps:2*steps,:);
		uB = uSoln(1+2*steps:3*steps,:);
		for j=1:length(t)
			uPlot = zeros(nx,ny,colors);
			uPlot(:,:,1) = reshape(uR(j,:),nx,ny); 
			uPlot(:,:,2) = reshape(uG(j,:),nx,ny); 
			uPlot(:,:,3) = reshape(uB(j,:),nx,ny); 
			figure(fig), subplot(rows,cols,j+1), imshow(uint8(uPlot));
			title(strcat('Diffusion (t=',num2str(t(j)),')'));
		end
	end
	
	drawnow;
	
end