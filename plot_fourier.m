function plot_fourier(imgTS,imgTSF,fig)

	figure(fig);
	
	subplot(1,2,1), pcolor((log(abs(imgTS)))), shading interp, colormap(hot);
	title('Original');
	
	subplot(1,2,2), pcolor((log(abs(imgTSF)))), shading interp, colormap(hot);
	title('Filtered');
	
	drawnow;
	
end