% Shows the horizontal, vertical and mixed edges of lena.bmp.

detector = EdgeDetector(imread("lena.bmp"));

figure(1);
imshow(detector.image);

% hor = detector.HorizontalEdge();
% imwrite(hor, "hor_edge.bmp");
figure(2);
imshow(detector.HorizontalEdge());

% ver = detector.VerticalEdge();
% imwrite(ver, "ver_edge.bmp");
figure(3);
imshow(detector.VerticalEdge());

% all = detector.Edge();
% imwrite(all, "all_edge.bmp");
figure(4);
imshow(detector.Edge());
