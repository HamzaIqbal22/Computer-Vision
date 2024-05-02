%% Problem 1.

% Display Original Image
img = imread("lion.jpg");
imshow(img);
title ('The Lion - Original Image');

% Display Grey Image
subplot(2, 2, 1);
imggray = rgb2gray(img);
imshow(imggray);
title ('The Lion - Grayscale Image');

% Robert Edge Detector
subplot(2, 2, 2);
robert = edge(imggray,"roberts");
imshow(robert);
title('Robert Mask');

% Prewitt Edge Detector
subplot(2, 2, 3);
prewitt = edge(imggray,"prewitt");
imshow(prewitt);
title('Prewitt Mask');

% Sobel Edge Detector
subplot(2, 2, 4);
sobel = edge(imggray,"sobel");
imshow(sobel);
title('Sobel Mask');

%% Problem 3.

img = imread("lion.jpg");

% Greyscale Image
subplot(2, 2, 1);
imggray = rgb2gray(img);
imshow(imggray);
title('The Lion - Grayscale Image');

% Sharpened Image
sharpen = imsharpen(imggray);
subplot(2, 2, 2);
imshow(sharpen);
title('The Lion - Sharpened Image');

% High Boost Filtered Image k=1
subplot(2, 2, 3);
hbf = imsharpen(imggray, "radius", 5, "amount", 1);
imshow(hbf);
title('HBF Lion Image k=1');


% High Boost Filtered Image k=5
subplot(2, 2, 4);
hbf2 = imsharpen(imggray, "radius", 5, "amount", 5);
imshow(hbf2);
title('HBF Lion Image k=5');

%% Problem 4.

% Original & Grayscale Image
subplot(3,2,1);
img = imread("lion.jpg");
imshow(img);
title('The Lion - Original Image');

subplot(3,2,2);
imggray = rgb2gray(img);
imshow(imggray);
title('The Lion - Grayscale Image');

% Noise Levels
noise1 = 0.25;
noise2 = 0.001;

% Gaussian noise #1
subplot(3,2,3);
gaus1 = imnoise(imggray,"gaussian", noise1);
imshow(gaus1);
title('Image #1 - Gaussian Noise of 0.25');

% Gaussian noise #2
subplot(3,2,4);
gaus2 = imnoise(imggray,"gaussian", noise2);
imshow(gaus2);
title('Image #2 - Gaussian Noise of 0.001');

% Average Filter
subplot(3,2,5);
AvgFilter = filter2(fspecial('average',3),gaus1)/255;
imshow(AvgFilter);
title('Average filter on Gaussian Image #1');

% Gaussian Filter
subplot(3,2,6);
GausFilter = imgaussfilt(gaus2, 0.9);
imshow(SecondGaus); 
title('Gaussian filter on Gaussian Image #2');

%% Part 2

% Display Original Image
figure;
img = imread('lowlight.jpg');
imshow(img);
title ('Lowlight - Original Image');

% Display Greyscale Image
figure;
imggray = rgb2gray(img);
imshow(imggray);
title ('Lowlight - Grayscale Image');

% Inverted Image
figure;
imgInv = imcomplement(img);
imshow(imgInv);
title('Lowlight - Inverted Image');

% Apply haze reduction algorithm 
figure;
haze = imreducehaze(imgInv);
imshow(haze);
title('Lowlight - Haze Reduction on Inverted Image');

%  Invert the haze reduction
figure;
invHaze = imcomplement(haze);
imshow(invHaze);
title('Lowlight - Inverted Haze-Reduction Image');

