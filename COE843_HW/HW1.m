%% Problem 1.

%% Upload Image


subplot (2,2,1);
img = imread ('lion.jpg');
imshow(img);
title ('The Lion - Original Image');


% Grayscale

subplot (2,2,2);
imggray = rgb2gray (img);
imshow(imggray);
title ('The Lion - Grayscale Image');


% Power-Law transformation with y = 0.3

subplot (2,2,3);
gammalow = imadjust(imggray,[],[],0.3);
imshow(gammalow);
title ('The Lion - Power law with y = 0.3');


% Power-Law transformation with y = 3

subplot (2,2,4);
gammahigh = imadjust(imggray,[],[],3);
imshow(gammahigh);
title ('The Lion - Power law with y = 3');

%% Problem 2.

% Grayscale Image
figure;
imshow(imggray);
title ('The Lion - Grayscale Image');

% 8-Bit Plane Slicing
bit1 = double (bitget(imggray,1));
bit2 = double (bitget(imggray,2));
bit3 = double (bitget(imggray,3));
bit4 = double (bitget(imggray,4));
bit5 = double (bitget(imggray,5));
bit6 = double (bitget(imggray,6));
bit7 = double (bitget(imggray,7));
bit8 = double (bitget(imggray,8));

subplot (3,3,1);
imshow (bit1);
title ('1-bit slice Image');

subplot (3,3,2);
imshow (bit2);
title ('2-bit slice Image');

subplot (3,3,3);
imshow (bit3);
title ('3-bit slice Image');

subplot (3,3,4);
imshow (bit4);
title ('4-bit slice Image');

subplot (3,3,5);
imshow (bit5);
title ('5-bit slice Image');

subplot (3,3,6);
imshow (bit6);
title ('6-bit slice Image');

subplot (3,3,7);
imshow (bit7);
title ('7-bit slice Image');

subplot (3,3,8);
imshow (bit8);
title ('8-bit slice Image');

% Reconstruct using highest 4 bits 
c5 = bit5 * 2^4;
c6 = bit6 * 2^5;
c7 = bit7 * 2^6;
c8 = bit8 * 2^7;

high4 = uint8 (c5+c6+c7+c8);

subplot (3,3,9);
imshow (high4);
title ('Highest 4-bits Image');

%% Problem 3.

% Grayscale Histogram Before
figure;
subplot (2,2,1);
imhist(imggray,256);
axis ([0 260 0 12000]);
title ('Gray Scale Image - Histogram Before');

% Power-Law (y = 0.3) Histogram Before
subplot (2,2,2);
imhist(gammalow,256);
axis ([0 260 0 12000]);
title ('Power Law y = 0.3 - Histogram Before');

% Power-Law (y = 3) Histogram Before
subplot (2,2,3);
imhist(gammahigh,256);
axis ([0 260 0 12000]);
title ('Power Law y = 3 - Histogram Before');

% Histogram Equalization of GreyScale
figure;
subplot (2,2,1);
axis ([0 260 0 12000]);
histeq (imggray, 256);
title ('Greyscale - Histogram Equalization');

% Histogram Equalization of Power-Law (y = 0.3)
subplot (2,2,2);
axis ([0 260 0 12000]);
histeq (gammalow,256);
title ('Power Law y = 0.3 - Histogram Equalization');

% Histogram Equalization of Power-Law (y = 3)
subplot (2,2,3);
axis ([0 260 0 12000]);
histeq (gammahigh,256);
title ('Greyscale - Histogram Equalization');

% After Histogram Equalization of Greyscale Image
figure;
subplot (2,2,1);
imhist(histeq(imggray,256),256);
title ('Grayscale - After Histogram Equalization');

% After Histogram Equalization of Power-Law (y = 0.3)
subplot (2,2,2);
imhist(histeq(gammalow,256),256);
title ('Power Law y = 0.3 - After Histogram Equalization');

% After Histogram Equalization of Power-Law (y = 3)
subplot (2,2,3);
imhist(histeq(gammahigh,256),256);
title ('Power Law y = 3 - After Histogram Equalization');

%% Part 2.

% Step 1: Transform Image with Simple Shear

a = 0.56;
T = maketform('affine', [1 0 0; a 1 0; 0 0 1]);
A = imread('yandhi.jpg');
h1 = figure;

imshow(A); 
title('Original Image');

blue = [0 0 255]';
R = makeresampler({'cubic','nearest'},'fill');
B = imtransform(A,T,R,'FillValues',blue); 
h2 = figure; 
imshow(B);
title('Sheared Image');

% Step 2: Explore Transformation

[U,V] = meshgrid(0:64:1510,0:64:1510);
[X,Y] = tformfwd(T,U,V);
gray = 0.65 * [1 1 1];

figure(h1);
hold on;
line(U, V, 'Color',gray);
line(U',V','Color',gray);

figure(h2);
hold on;
line(X, Y, 'Color',gray);
line(X',Y','Color',gray);

% Step 3: Comparing fill, replicate & bound

% Fill
 R = makeresampler({'cubic','nearest'},'fill');
Bf = imtransform(A,T,R,'XData',[-149 1500],'YData',[-149 1400],...
                 'FillValues',blue);

figure, imshow(Bf);
title('Pad Method = ''fill''');

% Replicate
R = makeresampler({'cubic','nearest'},'replicate');
Br = imtransform(A,T,R,'XData',[-149 1500],'YData', [-149 1400]);

figure, imshow(Br);
title('Pad Method = ''replicate''');

% Bound
R = makeresampler({'cubic','nearest'}, 'bound');
Bb = imtransform(A,T,R,'XData',[-149 1500],'YData',[-149 1400],...
                 'FillValues',blue);
figure, imshow(Bb);
title('Pad Method = ''bound''');

% Step 4: Circular & Symmetric

Thalf = maketform('affine',[1 0; a 1; 0 0]/2);

R = makeresampler({'cubic','nearest'},'circular');
Bc = imtransform(A,Thalf,R,'XData',[-149 1500],'YData',[-149 1400],...
                 'FillValues',blue);
figure, imshow(Bc);
title('Pad Method = ''circular''');


R = makeresampler({'cubic','nearest'},'symmetric');
Bs = imtransform(A,Thalf,R,'XData',[-149 1500],'YData',[-149 1400],...
                 'FillValues',blue);
figure, imshow(Bs);
title('Pad Method = ''symmetric''');
