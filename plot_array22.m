function plot_array22(img1,title1,img2,title2,img3,title3,img4,title4,fig)

	figure(fig);
	
	subplot(2,2,1), imshow(uint8(img1));
	title(title1);
	
	subplot(2,2,2), imshow(uint8(img2));
	title(title2);
	
	subplot(2,2,3), imshow(uint8(img3));
	title(title3);
	
	subplot(2,2,4), imshow(uint8(img4));
	title(title4);
	
	drawnow;
	
end