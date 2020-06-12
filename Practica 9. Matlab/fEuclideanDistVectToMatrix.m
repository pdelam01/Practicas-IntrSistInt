function DistancesVector= fEuclideanDistVectToMatrix(Vector, Matrix)
% Returns a row vector containing the Euclidean distance between the Vector
% and each element of the matrix "Matrix"
% Both must have the same number of rows, corresponding with the features
% of each sample. %
% INPUT:
% - Vector: Column vector whose distance to the elements of x is going to be computed.
% - Matrix: Matrix containing the dataset.
% It has as many rows as features per sample and as many columns as samples.
%
%
%
%
%
%
% OUTPUT:
% -DistancesVector: a row vector with the distances between Vector and each element in Matrix
% % % %

NumberOfColums = size(Matrix,2);
%% 2. Replicating the rows of the Vector as many times as colums are in Matrix % This way, it is easiest to operate
Vector = repmat(Vector, 1, NumberOfColums);
%% 3. Computing the Euclidean distance
DistancesVector = sqrt(sum((Vector-Matrix).^2, 1));
end