function plot_array23(img1,title1,img2,title2,img3,title3,img4,title4,img5,title5,img6,title6,fig)

	figure(fig);
	
	subplot(2,3,1), imshow(uint8(img1));
	title(title1);
	
	subplot(2,3,2), imshow(uint8(img2));
	title(title2);
	
	subplot(2,3,3), imshow(uint8(img3));
	title(title3);
	
	subplot(2,3,4), imshow(uint8(img4));
	title(title4);
	
	subplot(2,3,5), imshow(uint8(img5));
	title(title5);
	
	subplot(2,3,6), imshow(uint8(img6));
	title(title6);
	
	drawnow;
	
end