% Example using JetrawTiff to read Jetraw compressed TIFF files.

% Create JetrawTiff object and open compressed TIFF file.
tif = JetrawTiff('example_image.p.tif', 'r');
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
tif.close()

% Write dpcore prepared image into jetraw compressed TIFF file. 
tif = JetrawTiff('example_write_image.p.tif', 'w');
tif.write(imageStack);
tif.close();

% Create JetrawTiff object specifying JetrawTiff lib path and open compressed TIFF file.
%tif = JetrawTiff('example_image.p.tif', 'r', 'path_to_jetrawtiff_lib');
%imageStack = tif.read();
%tif.close();