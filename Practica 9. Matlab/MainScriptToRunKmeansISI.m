% Script MainScriptToRunKmeansISI for testing the kmeans clustering algorithm
% ISI Lab. Universidad de Leon
% EAlegre April2013

%% 1) Reading images from disk
%% 1.1) Read the 3 images dataset
% A. "Read" images
[CImaNamRed,ThePathRed]= fReadDirNamAndIma13('jpg','RedImages');
% CImaNamRed <2x35 cell>
% B. "Green" images
[CImaNamGreen,ThePathGreen]= fReadDirNamAndIma13('jpg','GreenImages');
% CImaNamGreen <2x35 cell>
% C. "Mixed" images, with Red and Green colors
[CImaNamMixed,ThePathMixed]= fReadDirNamAndIma13('jpg','MixedImages');
% CImaNamMixed <2x10 cell>
%% 1.2) Visualize the images stored in the cell array
% A. Visualize the RED images
fVisualizeImagesInCell(CImaNamRed);
% B. Visualize the GREEN images
fVisualizeImagesInCell(CImaNamGreen);
% C. Visualize the MIXED images
fVisualizeImagesInCell(CImaNamMixed);
% To visualize any image, change the number of image that you want to
% visualize, in the cell containing the colour images and uncomment these
% lines
 % NumIma=5;
 % figure, imshow(CImaNamMixed{1,NumIma}), title(numb2str(NumIma))
%% 2) Extract the feature vectors from the images
% Computes the average value for each colour plane in every image stored in
% the cell array. The result is a 3-elements vector with the R, G, and B
% average colour
RGBMeansMatrixRed= fCellImageToRGBVectors(CImaNamRed);
RGBMeansMatrixGreen= fCellImageToRGBVectors(CImaNamGreen);
RGBMeansMatrixMixed= fCellImageToRGBVectors(CImaNamMixed);

%% 3) Classify the red and green images, without knowing the labels, in 2
% clusters, using 2-means (kmeans with k=2)

% 3.1) Create the dataset
Dataset=[RGBMeansMatrixRed,RGBMeansMatrixGreen];
K=2;
% 3.2) Classify the vectors in the dataset using kmeans
VisualizeIterationsEvol=1; % Change to 0 if you do not want to check how
 % the centroids evolve
[ClosestCentroidToEachSample,Centroids ] =...
 fKmeansISI(Dataset, K, VisualizeIterationsEvol);
% 3.3) Visualize the point's distribution in the space
fPlotDataPoints(Dataset, Centroids,ClosestCentroidToEachSample,K,...
 strcat('Red and Green, K=',num2str(K)))
%% 4) Classify the red and green images, without knowing the labels, in 5
% clusters, using 5-means (kmeans with k=5)
% 4.1) Create the dataset
Dataset=[RGBMeansMatrixRed,RGBMeansMatrixGreen];
K=5;
% 4.2) Classify the vectors in the dataset using kmeans
VisualizeIterationsEvol=1; % Change to 0 if you do not want to check how
 % the centroids evolve
[ ClosestCentroidToEachSample,Centroids ] =...
 fKmeansISI(Dataset, K, VisualizeIterationsEvol);
% 4.3) Visualize the point's distribution in the space
fPlotDataPoints(Dataset, Centroids,ClosestCentroidToEachSample,K,...
 strcat('Red and Green, K=',num2str(K)))
%% 5) Classify the red, green and mixed images, without knowing the labels,
% in 3 clusters, using 3-means (kmeans with K=3)
% 5.1) Create the dataset
Dataset=[RGBMeansMatrixRed,RGBMeansMatrixGreen,RGBMeansMatrixMixed];
K=3;
% 5.2) Classify the vectors in the dataset using kmeans
VisualizeIterationsEvol=1;
[ClosestCentroidToEachSample,Centroids ] =...
 fKmeansISI(Dataset, K, VisualizeIterationsEvol);
% 5.3) Visualize the point's distribution in the space
fPlotDataPoints(Dataset, Centroids,ClosestCentroidToEachSample,K,...
 strcat('Red, Green and Mixed, K=',num2str(K)))
%% 6) Classify the red, green and mixed images, without knowing the labels,
% in 6 clusters, using 6-means (kmeans with K=6)
% 6.1) Create the dataset
Dataset=[RGBMeansMatrixRed,RGBMeansMatrixGreen,RGBMeansMatrixMixed];
K=6;
% 6.2) Classify the vectors in the dataset using kmeans
VisualizeIterationsEvol=1;
[ClosestCentroidToEachSample,Centroids ] =...
 fKmeansISI(Dataset, K, VisualizeIterationsEvol);
% 6.3) Visualize the point's distribution in the space
fPlotDataPoints(Dataset, Centroids,ClosestCentroidToEachSample,K,...
 strcat('Red, Green and Mixed, K=',num2str(K)))

%% 7) Visualize image in Clusters
% 7.1) Compose the Cell Arrays containing the images
CImaNamAllImages=[CImaNamRed,CImaNamGreen,CImaNamMixed];
% 7.2) Index of the images in each cluster
NumSamples=length(ClosestCentroidToEachSample);
VIndexCluster=zeros(K,NumSamples);
for i=1:K % K=6 because the previous settings
 VIndexCluster(i,:)=ClosestCentroidToEachSample==i;
end
VIndexCluster=logical(VIndexCluster);
% 7.3) Visualize all the images in each subcluster
for i=1:K
 fVisualizeImagesInCell(CImaNamAllImages(:,VIndexCluster(i,:)));
end