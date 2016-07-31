%% Kellen Betts  |  kellen.betts@gmail.com
%% Date:  120214  |  Version:  1.0
%% Description: 	Image processing for "global" noise using linear filters
%%					(Gaussian and Shannon), difffusion process, and combination.
	
clear all; close all;

%%===============================================================     initialize
	
derek1 = double(imread('../data/derek1','jpg'));
derek2 = double(imread('../data/derek2','jpg'));

%figure(1);
%subplot(1,2,1), imshow(uint8(derek1)), title('derek1');
%subplot(1,2,2), imshow(uint8(derek2)), title('derek2');

% filter parameters
sigma = 0.00025;
filterType = 'gaussian';

% diffusion parameters
D = 0.0005;
tspan = [0.005 0.006 0.007 0.008 0.009 0.01 0.02 0.03];		% need 8
pick = 6;

% pick method(s)
direction = 'filtOnly';
plotAll = 0;

switch direction

%%==============================================================     filter only

case 'filtOnly'
	
	% derek1
	[filt1,ts1,tsf1] = filter(derek1,sigma,'gaussian');
	[filt1S,ts1S,tsf1S] = filter(derek1,sigma,'shannon');
	
	% derek2
	[filt2,ts2,tsf2] = filter(derek2,sigma,'gaussian');
	[filt2S,ts2S,tsf2S] = filter(derek2,sigma,'shannon');
	
	if plotAll == 1
	
		% derek1
		plot_filtered(derek1,filt1,2);
		plot_fourier(ts1,tsf1,3);

		% derek2
		plot_filtered(derek2,filt2,4);
		plot_fourier(ts2,tsf2,5);

		% plot individual
		plot_array22(derek1,'Original (derek1)',filt1,'Filtered (derek1)',...
			derek2,'Original (derek2)',filt2,'Filtered (derek2)',6);

		% plot individual
		plot_array22(derek1,'Original (derek1)',filt1S,'Filtered (derek1)',...
			derek2,'Original (derek2)',filt2S,'Filtered (derek2)',7);
		
	end
	
	% plot comparison	
	plot_array23(derek1,'Original (derek1)',filt1,'Filtered (Gaussian)',filt1S,'Filtered (Shannon)',...
		derek2,'Original (derek2)',filt2,'Filtered (Gaussian)',filt2S,'Filtered (Shannon)',8);
	
%%===========================================================     diffusion only

case 'diffOnly'

		% derek1
		[t1,diff1_full] =  diffusion('global',derek1,tspan,D);
		diff1 = imgPick(derek1,diff1_full,length(t1),pick);

		% derek2
		[t2,diff2_full] =  diffusion('global',derek2,tspan,D);
		diff2 = imgPick(derek2,diff2_full,length(t2),pick);

		if plotAll == 1

			% derek1
			plot_diffSeries(derek1,t1,diff1_full,2);

			% derek2
			plot_diffSeries(derek2,t2,diff2_full,3);

		end

		% plot results
		plot_array22(derek1,'Original (derek1)',diff1,'Diffusion (derek1)',...
			derek2,'Original (derek2)',diff2,'Diffusion (derek2)',4);
			
%%===============================================     diffusion versus filtering

case 'versus'
	
	% color only
	
	% filtering
	[filt1,ts1,tsf1] = filter(derek1,sigma,'gaussian');
	[filt1S,ts1S,tsf1S] = filter(derek1,sigma,'shannon');
	
	% diffusion
	[t1,diff1_full] =  diffusion('global',derek1,tspan,D);
	diff1 = imgPick(derek1,diff1_full,length(t1),pick);
	
	% plot results
	plot_array22(derek1,'Original',diff1,'Diffusion',...
		filt1,'Filter (Gaussian)',filt1S,'Filter (Shannon)',2);
	
%%======================================================     filter then diffuse

case 'filtFirst'

	% filter then diffuse
	
	% derek1
	[filt1,ts1,tsf1] = filter(derek1,sigma,filterType);
	[t1,filtDiff1] = diffusion('global',filt1,tspan,D);

	% derek2
	[filt2,ts2,tsf2] = filter(derek2,sigma,filterType);
	[t2,filtDiff2] = diffusion('global',filt2,tspan,D);
	
	if plotAll == 1
	
		% derek1
		plot_filtered(imgOrig1,filt1,2);
		plot_fourier(ts1,tsf1,3);
		plot_diffSeries(filt1,t1,filtDiff1,4);

		% derek2
		plot_filtered(imgOrig2,filt2,5);
		plot_fourier(ts2,tsf2,6);
		plot_diffSeries(filt2,t2,filtDiff2,7);
	
		% combined array
		plot_array22(derek1,'Original (derek1)',filt1,'Filtered (derek1)',...
			derek2,'Original (derek2)',filt2,'Filtered (derek2)',8);
		
	end
	
	% grab/reshape best time points
	uPlot1 = imgPick(derek1,filtDiff1,length(t1),pick);	
	uPlot2 = imgPick(derek2,filtDiff2,length(t2),pick);

	% plot results
	plot_array23(derek1,'Original (derek1)',filt1,'Filtered (derek1)',uPlot1,'Filtered + Diffusion (derek1)',...
		derek2,'Original (derek2)',filt2,'Filtered (derek2)',uPlot2,'Filtered + Diffusion (derek2)',9);

%%======================================================     diffuse then filter

case 'diffFirst'
	
	% derek1
	[t1,diff1_full] =  diffusion('global',derek1,tspan,D);
	diff1 = imgPick(derek1,diff1_full,length(t1),pick);
	[diffFilt1,ts1,tsf1] = filter(diff1,sigma,filterType);

	% derek2
	[t2,diff2_full] =  diffusion('global',derek2,tspan,D);
	diff2 = imgPick(derek2,diff2_full,length(t2),pick);
	[diffFilt2,ts2,tsf2] = filter(diff2,sigma,filterType);

	if plotAll == 1

		% derek1
		plot_diffSeries(derek1,t1,diff1_full,2);
		plot_filtered(imgOrig1,diffFilt1,3);
		plot_fourier(ts1,tsf1,4);
	
		% derek2
		plot_diffSeries(derek2,t2,diff2_full,5);
		plot_filtered(imgOrig2,diffFilt2,6);
		plot_fourier(ts2,tsf2,7);
		
	end

	% plot results
	plot_array23(derek1,'Original (derek1)',diff1,'Diffusion (derek1)',diffFilt1,'Diffusion + Filtered (derek1)',...
		derek2,'Original (derek2)',diff2,'Diffusion (derek2)',diffFilt2,'Diffusion + Filtered (derek2)',8);

end

%%======================================================================     end
