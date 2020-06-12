function DistanceValue= fEuclideanDistVectToVect(FirstVector, SecondVector)
% Returns the value correponging with the Euclidean distance between two
% vectors.
% Both vectors must have the same number of elements
%
% INPUT:
%   - FirstVector: The first vector.
%   - SecondVector: The second one.
%   
% OUTPUT:
%   -DistancesValue: the distance between both of them
%
% EAlegre April2013

%% 1. Check if both inputs are vectors

if  ~and(isvector(FirstVector),isvector(SecondVector))
    % The "if" returs 1 when both are vectors
    % As the result of the condition is the NOT AND,...
    % The function finishes if any of them is not a vector
   sprintf('ERROR in fEuclideanDistVectToVect: Both inputs must be a vector')
   return
   
end


%% 2. Checking the shape and number of elements in each vector

% Dimensions of each vector
DimFirstVec=size(FirstVector);
DimSecondVec=size(SecondVector);

% Check if it is a column vector and if it not, transpose it

if DimFirstVec(1)==1 % is a row vector
    FirstVector=FirstVector'; % transpose it
end

if DimSecondVec(1)==1 % is a row vector
    SecondVector=SecondVector'; % transpose it
end


% Check if both vectors have the same length
if ~length(FirstVector)==length(SecondVector), % if they have not same length
     sprintf...
         ('ERROR in fEuclideanDistVectToVect: Vectors have different lengths')
   return
end
    


%% 3. Computing the Euclidean distance 
DistanceValue = sqrt(sum((FirstVector-SecondVector).^2, 1));
    
end