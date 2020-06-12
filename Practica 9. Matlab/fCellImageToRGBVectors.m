function RGBMeansMatrix=fCellImageToRGBVectors(CImaNamColor)
% RGBMeansMatrix=fCellImageToRGBVectors(CImaNamColor)
% This function expects a cell array containing in its first row the images
% to be processed. It takes each image and returns a 3-dimensions vector
% for each one. The vector's elements are the average value of the pixel
% level for each color plane, R (Red), G (Green) and B (Blue)
% INPUT:
%       CImaNamColor: cell array contanining in its first row the images
% 
% OUTPUT:
%       RGBMeansMatrix: A Matrix containing the RGB average color for each
%       image in the input cell array
% 
% EAlegre April2013

% Number of images in the cell array to be processed
NumImages=length(CImaNamColor);

% Preallocation for speed
RGBMeansMatrix=zeros(3,NumImages);

% Obtains the RGB average vector for each image and stores it in the
% RGBMeansMatrix

for i=1:NumImages
    RGBMeansMatrix(1,i)=mean(mean(im2double(CImaNamColor{1,i}(:,:,1))));
    RGBMeansMatrix(2,i)=mean(mean(im2double(CImaNamColor{1,i}(:,:,2))));
    RGBMeansMatrix(3,i)=mean(mean(im2double(CImaNamColor{1,i}(:,:,3))));
end % for

end