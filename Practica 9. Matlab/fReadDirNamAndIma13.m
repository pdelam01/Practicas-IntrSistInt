function [CImaNam,ThePath]=fReadDirNamAndIma13...
    (extension,message,defaultpath,varargin)
%% [CImaNam,ThePath]=fReadDirNamAndIma13...
%                               (extension,message, defaultpath))
%
% This function saves the images and their names in the CellArray CImaNam.
% The user is asked to choose a directory and all the images and their
% names with the extension provided as parameter are stored in the cell
% array "CImaNam" and returned.
%
%
% INPUT: 
%      - extension: -char- that is the file extension of the files such as 
%       'jpg', 'bmp', 'tif', etc. It has to be a Matlab supported format.
%      - message: a string in case you could pass a message to be showed
%      - defaultpath: the directory where de windows will be opened
%       
% OUTPUT:
%      - CImaNam: A cell array containing the images and theirs names
%      - ThePath: The path chosen for the user
%
% EAlegre April2013

%% 0. Checking the input arguments

if nargin == 0
    extension = 'jpg';
    message = 'Where are the files?';
    defaultpath=pwd; % Is the current directory

elseif nargin == 1
    message = 'Where are the files?';
    defaultpath=pwd; % Is the current directory
    
elseif nargin == 2
    defaultpath=pwd; % Is the current directory
end

   
%% 1. Getting directory name where the images are stored
% Display standard dialog box for selecting a directory ........

%%
try
    ThePath = uigetdir...
        (defaultpath,message);
catch MessError
    beep;
    sprintf('Error selecting directory')
    sprintf(MessError.message)
end


%% 2. Saving in "CNames" the name of every image with "extension" extension, 

% Put contents of the directory selected in struct
SNamImages=dir(ThePath);

% Checking if the extension has a dot
NSizeExtension=size(extension,2);
if NSizeExtension==3
    extension=strcat('.',extension);
elseif or(...
        or(NSizeExtension<3,NSizeExtension>4),...
        and(NSizeExtension==4,~strcmp(extension(1),'.')))
    disp('Error de longitud de la extension. Introduzca 3 caracteres sin punto.')
    return
end

%% 
NNumFiles=size(SNamImages,1);
% Preallocation for speed
CNames=cell(1,NNumFiles);

j=0;
for i=1:NNumFiles
    if size(SNamImages(i).name,2)>4
        if strcmpi(SNamImages(i).name(end-3:end),extension)
            j=j+1;
            CNames{j}=SNamImages(i).name;
        end
    end
end
%
if isempty(SNamImages)
    disp('There are not files with that extension')
    return;
end

% Removing empty cells in the last positions
NNames=size(CNames,2);
while isempty(CNames{NNames})
    CNames=CNames(1,1:NNames-1);
    NNames=NNames-1;
end

%% 3. Reading the images which names are in CNames
% Loading the images into the cell ........
% Returns the number of images read

% Displaying the progress bar ...
h = waitbar(0,'Reading images ...');

numimag=size(CNames,2);
% preallocation for speed
CImaNam=cell(numimag,2);
%%
for i=1:numimag
    % obtains the name of each image
    thename=CNames{i};
    % Reading every image 
    image=imread(fullfile(ThePath,thename));
    % Saving image and its name into cell
    CImaNam{i,1}=image;
    
    CImaNam{i,2}=thename;
    
    waitbar(i/numimag)
end

close(h) 
CImaNam=CImaNam';
end