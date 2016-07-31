function [outT,outSoln] = diffusion(area,imgOrig,tspan,params)
	%% Kellen Betts  |  kellen.betts@gmail.com
	%% Date:			120214
	%% Description: 	Function that implements diffusion process for image processing.

	%%===============================================================     initialize
	
	if length(tspan) ~= 8
		% for plotting
		'error... need length(tspan) = 8'
		return;
	end
	
	[nx ny colors] = size(imgOrig);
	steps = length(tspan);
	uSoln = zeros(colors*steps,nx*ny);

	%%===========================================================     build L matrix

	% spatial domain
	x = linspace(0,1,nx);
	dx = x(2) - x(1);
	y = linspace(0,1,ny);
	dy = y(2) - y(1);

	% build Dx matrix
	onex = ones(nx,1);
	Dx = (spdiags([onex -2*onex onex],[-1 0 1],nx,nx))/dx^2;
	Ix = eye(nx);

	% build Dy matrix
	oney = ones(ny,1);
	Dy = (spdiags([oney -2*oney oney],[-1 0 1],ny,ny))/dy^2;
	Iy = eye(ny);

	% build full deriv matrix
	L = kron(Iy,Dx) + kron(Dy,Ix);
	%figure(L), spy(L);

	%%=====================================================================     body
	
	switch area
	
	case 'global'
	
		coeff = params(1);
		
		for j=1:colors
			u = reshape(imgOrig(:,:,j),nx*ny,1);
			[t,uSoln((1+(j-1)*steps:j*steps),:)] = ode113('rhs',tspan,u,[],L,coeff);
		end
		
	case 'local'
		
		C = params(1);
		sigma = params(2);
		a = params(3);
		b = params(4);
		
		% build spatial coeff matrix
		D2 = ones(nx,ny);
		for jx=1:nx
		    for jy=1:ny
		        D2(jx,jy) = C * D2(jx,jy) * exp(-sigma*(jx-a).^2 - sigma*(jy-b).^2);
		    end
		end
		d2 = reshape(D2,nx*ny,1);
		D = spdiags(d2,0,nx*ny,nx*ny);
		
		for j=1:colors
			u = reshape(imgOrig(:,:,j),nx*ny,1);
			[t,uSoln((1+(j-1)*steps:j*steps),:)] = ode113('rhs',tspan,u,[],L,D);
		end

	end
	
	%%===================================================================     output
	
	outT = t;
	outSoln = uSoln;

	%%======================================================================     end

end