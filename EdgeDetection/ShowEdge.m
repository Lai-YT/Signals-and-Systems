% Shows the horizontal, vertical and mixed edges of lena.bmp.

detector = EdgeDetector(imread("lena.bmp"));

figure(1);
imshow(detector.image);

figure(2);
imshow(detector.HorizontalEdge());

figure(3);
imshow(detector.VerticalEdge());

figure(4);
imshow(detector.Edge());
