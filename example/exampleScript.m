% Example using JetrawTiff to read/write Jetraw compressed TIFF files

% EXAMPLE 1: read dpcore prepared TIFF file and write Jetraw compressed TIFF file
% get tiff details from each page
tiffProperties = imfinfo('example_image_stack.tif');
width = tiffProperties.Width;
height = tiffProperties.Height;
pages = size(tiffProperties, 1);
imageStack = zeros(height, width, pages, 'uint16');

% read all pages from TIFF file
for pageIdx = 1 : size(tiffProperties, 1)
    imageStack(:,:,pageIdx) = imread('example_image_stack.tif', pageIdx);
end

% Write dpcore prepared image into jetraw compressed TIFF file
tif = JetrawTiff('example_image_stack.p.tif', 'w');
tif.write(imageStack);
tif.close();

% EXAMPLE 2: read Jetraw compressed TIFF file and write Jetraw compressed TIFF file again. 
% Create JetrawTiff object and open compressed TIFF file
tif = JetrawTiff('example_image_stack.p.tif', 'r');
% get image properties
width    = tif.width();  % has the width of the image
height   = tif.height(); % has the height of the image
numPages = tif.pages();  % has the number of pages of the stack

% Read specified page/s
imagePage  = tif.readPage(2);
imagePages = tif.readPage([4, 8, 10, 20]);

% Read whole stack
imageStack = tif.read();

% Close TIFF image
tif.close();

% Write dpcore prepared image into jetraw compressed TIFF file
tif = JetrawTiff('example_image_stack.p.tif', 'w');
tif.write(imageStack);
tif.close();

% OPTION in case Jetraw libraries are not in PATH
% Create JetrawTiff object specifying JetrawTiff lib path and open compressed TIFF file.
%tif = JetrawTiff('example_image.p.tif', 'r', 'path_to_jetrawtiff_lib');
%imageStack = tif.read();
%tif.close();