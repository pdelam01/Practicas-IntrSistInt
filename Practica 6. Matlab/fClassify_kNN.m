function Y_assign = fClassify_kNN(X_train, Y_train, X_test, k)
% This function implements the kNN classification algorithm with the
% eucludean distance
%
% INPUT
%   - X_train: Matrix (n_train x n), where n_Train is the number of 
%   training elements and n is the number of features (the length of the 
%   feature vector)
%   - Y_train: The classes of the elements in the training set. It is a
%   vector of length n_train with the number of the class.
%   - X_test: matrix (n_test x n), where n_test is the number of elements 
%   in the test set and n is the number of features (the length of the 
%   feature vector).
%   - k: Number of nearest neighbours to consider in order to make an
%   assignation
%
% OUTPUT
%   A vector with length n_test, with the classess assigned by the algorithm 
%   to the elements in the training set.
%

    numElemTest = size(X_test, 1);
    numElemTrain = size(X_train, 1);

    % Allocate space for the output
    Y_assign = zeros(1, numElemTest);
    
    % for each element in the test set...
    for i=1:numElemTest
        
        x_test_i = X_test(i,:);
        
        % 1 - Compute the Euclidean distance of the i-th test element to 
        % all the training elements
        % ====================== YOUR CODE HERE ======================
            for b=1:numElemTrain
                Dist(b,:) = pdist2(x_test_i,X_train(b,:),"euclidean");
            end
        % ============================================================
        
        % 2 - Order distances in ascending order and use the indices of the 
        % ordering
        % ====================== YOUR CODE HERE ======================
            [DistSort, Index] = sort(Dist);            
        % ============================================================

        % 3 - Take the k first classes of the training set
        % ====================== YOUR CODE HERE ======================
            FClasses = zeros(1,k);
            for j=1:k
                indice = Index(j,1);
                value = Y_train(:,indice);
                FClasses(:,j) = value;
            end
        % ============================================================
        
        % 4 - Assign to the i-th element the most frequent class
        % ====================== YOUR CODE HERE ======================
            count0 = 0;
            count1 = 0;
            for z=1:k
                if FClasses(z,:) == 0
                    count0 = count0 +1;
                else
                    count1 = count1 +1;
                end
            end
            
            if count0>count1
                Y_assign(1,i) = 0;
            else
                Y_assign(1,i) = 1;
            end
        % ============================================================
    end

end

