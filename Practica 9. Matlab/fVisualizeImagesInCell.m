function fVisualizeImagesInCell(CImaNam,NumColumsPlot,NumRowsPlot,varargin)
% fVisualizeImagesInCell(CImaNam,NumColumsPlot,NumRowsPlot)
% Visualiza the images contained in a cell array showing them in a subplot.
% The user can introduce the number of colums and the number of rows of the
% plot. If he or she do not introduce those values, the plot will be a
% matrix of images with 4 colums and as many rows as necessary to visualize
% all the images in the cell array
% 
% INPUT:
%   CImaNam: cell array contaning the images to visualize in its first row
%   NewFigure: if it is true, create
%   NumColumsPlot:  Number of colums of the visualization matrix
%   NumRowsPlot:    Number of rows of the visualization matrix
%
% EAlegre April2013



%% 0. Checking the input arguments
if nargin == 0,
        sprintf ('ERROR: You must introduce a cell array containing images')
        return
elseif nargin == 1,
    NumOfImages=length(CImaNam);
    NumColumsPlot=4;
    NumRowsPlot=ceil(NumOfImages/NumColumsPlot);
        
elseif nargin == 2,
    NumOfImages=length(CImaNam);
    NumRowsPlot=ceil(NumOfImages/NumColumsPlot);
end

%% Creating the figure and the subplot
% Figure
h=figure;
set(h,'Name','Images to visualize') % Set the name of the figure

% Show images
for i=1:NumOfImages,
    subplot(NumColumsPlot,NumRowsPlot,i);
    imshow(CImaNam{1,i}); title(num2str(i));
end % for

end