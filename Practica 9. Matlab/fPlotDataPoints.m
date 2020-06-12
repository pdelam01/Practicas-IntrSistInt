function fPlotDataPoints(X,Centroids,idx,K,TitleOfFigure)
% fPlotDataPoints(X,Centroids, idx, K, TitleOfFigure)
% Plots data points in X, coloring them so that those with 
% the same index assignments in idx have the same color
%
% INPUT:
%   - X: Matrix containing 3-dimensional vectors (vectors to visualize)
%   - Centroids: Values of the cluster's centroids
%   - idx: index indicating at which cluster belongs to each sample
%   - K: Number of clusters
%   - TitleOfFigure: Text that will be plotted as title in the figure
%
% EAlegre April2013


%% Create palette
palette = hsv(K + 1);
colors = palette(idx,:);

%% Plot the data
figure,
scatter3(X(1,:), X(2,:), X(3,:),30,colors);
hold on,
scatter3(Centroids(1,:), Centroids(2,:), Centroids(3,:),250,hsv(K),'s','fill');
title (TitleOfFigure)
end