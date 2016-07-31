%% Kellen Betts  |  kellen.betts@gmail.com
%% Date:			120214  |  Version:  1.0
%% Description: 	Image processing of localized noise difffusion process.

clear all; close all;

%%===============================================================     initialize

derek3 = double(imread('../data/derek3','jpg'));
derek4 = double(imread('../data/derek4','jpg'));

%figure(1);
%subplot(1,2,1), imshow(uint8(derek3)), title('derek3');
%subplot(1,2,2), imshow(uint8(derek4)), title('derek4');
	
tspan=[0.001 0.01 0.02 0.03 0.04 0.05 0.06 0.07];	% need 8
	
params = [0.01 0.01 155 162];

% derek3
[t3,soln3] = diffusion('local',derek3,tspan,params);
plot_diffSeries(derek3,t3,soln3,2);

% derek4
[t4,soln4] = diffusion('local',derek4,tspan,params);
plot_diffSeries(derek4,t4,soln4,3);

%%=============================================================     plot results

% color
pick = 4;
diff3 = imgPick(derek3,soln3,length(t3),pick);

% b&w
pick = 6
diff4 = imgPick(derek4,soln4,length(t4),pick);

plot_array22(derek3,'Original (derek3)',diff3,'Diffusion (derek3)',...
	derek4,'Original (derek4)',diff4,'Diffusion (derek4)',4);

%%======================================================================     end
