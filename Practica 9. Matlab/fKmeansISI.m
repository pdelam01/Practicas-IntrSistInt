function [ClosestCentroidToEachSample,NewMuCentroidsMatrix] =...
 fKmeansISI(Dataset,K,VisualizeIterationsEvol)
% [ClosestCentroidToEachSample,NewMuCentroidsMatrix] =...
% fKmeansISI(Dataset, K, VisualizeIterationsEvol)
%
% This function uses the kmeans algorithm to return the cluster "K" to
% which each sample belongs to in the ClosestCentroidToEachSample vector.
%
% INPUT:
% - Dataset: Matrix containing the Feature vectors of the samples to
% be clustered.
% - K: Number of clusters
% - VisualizeIterationsEvol: Flag. If it is true, values as the numbers
% of iterations employed, the distance between vectors and the old
% and new centroids are visualized.
% OUTPUT:
% - ClosestCentroidToEachSample: vector containing the label -is a
% number- of the closest centroid to every specific sample.
% - NewMuCentroidsMatrix: It is a matrix of size "number of
% characteristics in the feature vector" x "number of Ks", containing
% the values of the "number of K" centroids computed in the
% algorithm.
%
% EAlegre April2013
%
%% Algorithm
% k=number of clusters
% Training set, {x(1), x(2), ..., x(m)} with a number "m" of samples
% 1. Randomly initialize K cluster centroids mu1, mu2,..., muk,
% belonging to Rn
%
% Repeat{
%
% 2. Assign closest centroid to each sample
% for i=1 to m,
% Centroids(i)= index (from 1 to k) of cluster centroid closest to
% x(i)
%
% 3. Recompute centroids
% for k=1 to K
% muk=average (mean) of points assigned to cluster k
% } % Until there are not changes in the centroids

%% 0. Errors
% Check if the number of clusters is smaller than the number of samples
DimensionsDataset= size(Dataset);
NumberOfSamplesM=max(DimensionsDataset);
SizeFeatureVector=min(DimensionsDataset);
%%
if K>NumberOfSamplesM
 sprintf('Error. Number of cluster bigger than number of samples')
 return
end
%% 1. Randomly initialize K cluster centroids
% 1.1. Generate K pseudo-random numbers
% Preallocation for speed
IndexRandomInitializationSamples=zeros(1,K);
MuCentroidsMatrix=zeros(SizeFeatureVector,K);
NewMuCentroidsMatrix=zeros(SizeFeatureVector,K);
ClosestCentroidToEachSample=zeros(1,NumberOfSamplesM);
for i=1:K
RandomNumbers=rand(1,K,'single');
IndexRandomInitializationSamples(i)=...
 floor(NumberOfSamplesM*RandomNumbers(i));
end
% The first centroids are the previously initialized
% 1.2. Introduce the centroids in a matrix
 for i=1:K
    MuCentroidsMatrix(:,i)= Dataset(:,IndexRandomInitializationSamples(i));
 end


%% REPEAT THE FOLLOWING UNTIL THE CENTROIDS BE THE SAME ONES
DistanceBetweenOldAndNews=ones(1,K);
NumberOfIterationsNeeded=0;
while all(DistanceBetweenOldAndNews) % While distance is not 0
 % Just to know how many iterations were needed
 NumberOfIterationsNeeded=NumberOfIterationsNeeded+1;

 %% 2. Assign centroids to samples

 % 2.1 Compute the distances between each sample and each centroid
 % and assigns the closest centroid to each sample
 % (if the Statistic Toolbox is available in your system, an easiest way
 % is to use the "pdist" function)

 for i=1:NumberOfSamplesM
 % Compute the distance of each sample to each Centroid
 DistancesVector= fEuclideanDistVectToMatrix(Dataset(:,i),MuCentroidsMatrix);
 % Obtain the index of the minimum Centroid
 [~,IndexMinimum] = min(DistancesVector);
 % Assign the sample to the closest Centroid
 ClosestCentroidToEachSample(i)= IndexMinimum;
 end

 %% 3. Obtain new centroids by averaging the values on each previous cluster
 
 %
 for i=1:K
 IndicesClosestToK= ClosestCentroidToEachSample==i;
 NewMuCentroidsMatrix(:,i)= mean(Dataset(:,IndicesClosestToK),2);

 end


 %% 4. Check if the centroids are the same as in the previous iteration
 % If they are the same, the distance between the centroids will be 0
 %
 % Convert the centroid matrix in a single vector
 PreviousCentroids=reshape(MuCentroidsMatrix,1,[]);
 CurrentCentroids=reshape(NewMuCentroidsMatrix,1,[]);

 DistanceBetweenOldAndNews= fEuclideanDistVectToVect(PreviousCentroids,CurrentCentroids);
 %% Update the old centroids with the new ones

 if VisualizeIterationsEvol
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % If VisualizeIterationsEvol is true it will be possible to see how the
 % centroids and the distances evolve
 %
 NumberOfIterationsNeeded
 DistancesVector
 MuCentroidsMatrix
 NewMuCentroidsMatrix
 pause
 sprintf('Press any key to continue iterating')
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 MuCentroidsMatrix= NewMuCentroidsMatrix;

end % while
end % function