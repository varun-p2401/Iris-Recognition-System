% STEP: 0 Image Aquisition Process:-
clc; close all; warning off;

[FileName1,FilePath1] = uigetfile('*.jpg','Select captured Iris Image');
file1= fullfile(FilePath1, FileName1);

[FileName2,FilePath2] = uigetfile('*.jpg','Select the Iris Image for comparison');
file2= fullfile(FilePath2, FileName2);


% STEP:1 IMAGE AQUISITION

i=imread(file1);
subplot(1,2,1);
imshow(i);
title('STEP:1 Image Aquisition(Image:1)');

ii=imread(file2);
subplot(1,2,2);
imshow(ii);
title('STEP:1 Image Aquisition(Image:2)');

figure();



% STEP:2 GRAY SCALE CONVERSION

g =rgb2gray(i);
subplot(1,2,1);
imshow(g);
title('STEP:2 Conversion Gray Image:1');

gg=rgb2gray(ii);
subplot(1,2,2);
imshow(gg);
title('STEP:2 Conversion Gray Image:2');

figure();

% STEP:3 Subtraction of original image

k = imread(file1);
v= rgb2gray(k);
v = imsubtract(v,60);
subplot(1,2,1);
imshow(v);
title('STEP:3 Subtracted Gray Image:1');
 
kk = imread(file2);
vv =rgb2gray(kk);
vv = imsubtract(vv,60);
subplot(1,2,2);
imshow(vv);
title('STEP:3 Subtracted Gray Image:2');

figure();
 
% STEP:4 HISTOGRAM of the IMAGE
% Convert the image to unsigned 8 bit image and plot the histogram
 
z=double(g);
subplot(2,1,1);
imhist(g);
title('STEP:4 Histogram Image:1');

zz=double(gg);
subplot(2,1,2);
imhist(gg);
title('STEP:4 Histogram Image:2');

figure();


% STEP:5 CROPPED IMAGE

c=imcrop(g,[14 2 500 276]);
subplot(1,2,1);
imshow(c);
title('STEP:5 Cropped Image:1');

cc=imcrop(gg,[78 128 893 573]);
subplot(1,2,2);
imshow(cc);
title('STEP:5 Cropped Image:2');

figure();


% STEP:6 RESIZED IMAGE

r=imresize(c,[256,256],'nearest');
subplot(1,2,1);
imshow(r);
title('STEP:6 Resized Image:1');

rr=imresize(cc,[256,256],'nearest');
subplot(1,2,2);
imshow(rr);
title('STEP:6 Resized Image:2');

figure();

% STEP:7 IMAGE SMOOTHING

s= fspecial('gaussian',3);
f = imfilter(r,s); 
subplot(1,2,1);
imshow(f,[]),title('STEP:7 Gaussian Filter Smoothing Image:1 ');

ss= fspecial('gaussian',3);
ff = imfilter(rr,ss); 
subplot(1,2,2);
imshow(ff,[]),title('STEP:7 Gaussian Filter Smoothing Image:2');

figure();

%%%Image Segmentation Process:-

% STEP:8 CANNY EDGE DETECTION

e=edge(f,'canny');
subplot(1,2,1);
imshow(e);
title('STEP:8 Canny Filter Edge Detection Image:1');

ee=edge(ff,'canny');
subplot(1,2,2);
imshow(ee);
title('STEP:8 Canny Filter Edge Detection Image:2');

figure();



% STEP:9 GAMMA CORRECTION
%Adjust the Gamma to 0.8

S=edge(f,'sobel');
u=double(S);
subplot(1,2,1);
y= imadjust(u,[],[],0.02);  
imshow(y);
title('STEP:9 Gamma Adjusted Image:1');

SS=edge(ff,'sobel');
uu=double(SS);
subplot(1,2,2);
yy= imadjust(uu,[],[],0.02);  
imshow(yy);
title('STEP:9 Gamma Adjusted Image:2');
figure();

%STEP:10  EDGE DETECTION using Sobel filter

S1=edge(f,'sobel',0.02);
subplot(1,2,1);
imshow(S1);
title('STEP:10 Edge Detection by Sobel Filter Image:1');

SS1=edge(ff,'sobel',0.02);
subplot(1,2,2);
imshow(SS1);
title('STEP:10 Edge Detection by Sobel Filter Image:2');

figure();


%STEP:11 HOUGH'S TRANSFORM TO DETECT CIRCLES     %if layer is a rgb image turn into grayscale

i=imread(file1);
g=rgb2gray(i);
subplot(1,2,1);
imshow(g);
[centersiris1, radiiiris1] = imfindcircles(g,[53 54],'ObjectPolarity','dark', 'Sensitivity',0.98,'EdgeThreshold',0.1,'Method','TwoStage');
[centerspupil1, radiipupil1] = imfindcircles(g,[15 16],'ObjectPolarity','dark', 'Sensitivity',0.96,'EdgeThreshold',0.1,'Method','TwoStage');
viscircles(centersiris1,radiiiris1,'color','w');
viscircles(centerspupil1, radiipupil1,'Color','w');
title("STEP:11 Houghs Transform (image1)");


i=imread(file2);
gg=rgb2gray(i);
subplot(1,2,2);
imshow(gg);
[centersiris2, radiiiris2] = imfindcircles(gg,[130 135],'ObjectPolarity','dark', 'Sensitivity',0.99,'EdgeThreshold',0.1,'Method','TwoStage');
[centerspupil2, radiipupil2] = imfindcircles(gg,[27 28],'ObjectPolarity','dark', 'Sensitivity',0.96,'EdgeThreshold',0.1,'Method','TwoStage');
viscircles(centersiris2,radiiiris2,'color','w');
viscircles(centerspupil2, radiipupil2,'Color','w');
title("STEP:11 Houghs Transform (image2)");


%STEP :12 NORMALIZATION OF IMAGES
% Load the image
img1 = imread(file1);
% Input parameters
xPosPupil= 127;
yPosPupil= 80;
rPupil= 15;
xPosIris= 127;
yPosIris= 80;
rIris =50;
% Normalize the iris region according to daugmans model 
ir1 = rubberSheetNormalisation( img1, xPosPupil, yPosPupil, rPupil , xPosIris , yPosIris , rIris,'DebugMode', 1,'UseInterpolation', 0);
figure();
% Show Resulting image
subplot(2,1,1);
imshow(ir1);
title("STEP:12 Normalised Image:1");
imsave();


img2 = imread(file2);
% Input parameters
xPosPupil= 390;
yPosPupil= 270;
rPupil= 27;
xPosIris= 390;
yPosIris= 270;
rIris =130;
% Normalize the iris region according to daugmans model 
ir2 = rubberSheetNormalisation( img2, xPosPupil, yPosPupil, rPupil , xPosIris , yPosIris , rIris,'DebugMode', 1,'UseInterpolation', 0);
% Show Resulting image
subplot(2,1,2);
imshow(ir2);
title("STEP:12 Normalised Image:2");
imsave();

%STEP:13,14,15: ENHANCEMENT, EXTRACTION AND MATCHING USING HAMMING DISTANCE

[FileName1,FilePath1] = uigetfile('*.png','Select normalised image no.1');
file1= fullfile(FilePath1, FileName1);

[FileName2,FilePath2] = uigetfile('*.png','Select the normalised Image for 2 ,comparison');
file2= fullfile(FilePath2, FileName2);

%%Enhancement of normalised iris images%%
image1 = imread(file1);
image2 = imread(file2);
J= histeq(image1);
J2= histeq(image2);
figure();
subplot(2,1,1);
imshow(J);
title("STEP:13-Enhanced iris image 1");
subplot(2,1,2);
imshow(J2);
title("STEP:enhanced iris image 2");

%%Feature Extracrtion using wavelet pixels GaborFilter
[mag1,phase1] = imgaborfilt(J,256,0);   
[mag2,phase2] = imgaborfilt(J2,256,0);

%%Hamming distance between the normalised images
x1 = dec2bin(phase1,8);
y1 = dec2bin(phase2,8);

hd=0;
for i=1:length(x1)
    if(x1(i)~=y1(i))
        hd=hd+1;
        disp(hd);
    end
end
hd = hd/100000;

if hd < 0 && hd <= 0.2
h = msgbox('Same IRIS','Result');
elseif hd >= 0.4
h = msgbox('Different IRIS','Result');
elseif hd <=0.4 && hd >= 0.3
h = msgbox('Uncertain, Please run test again or change iris images','Result');
elseif hd ==0
h = msgbox('Same IRIS','Result');
end




             


















 