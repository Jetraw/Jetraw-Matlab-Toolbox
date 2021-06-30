# Jetraw Matlab Toolbox, the Matlab module for JetRaw  

This is a **Matlab toolbox** to read and write (under development) TIFF files with **JetRaw compression**. For more info visit
https://www.jetraw.com/

It is important to take into account that this Matlab toolbox is a wrapper to Jetraw's C library. This offers an easy way 
to integrate Jetraw into Matlab's environment but it affects performance in two aspects:
1. Loading Jetraw shared library takes around 2-3 seconds (it strongly depends on your machine's performance). This overhead only affects once as the library remains 
   loaded if the user does not clean the Matlab session. 
2. Compression/Decompression performance suffers a slowdown of around 15-20%. 

If your application demands the highest performance possible perhaps it is better to move to the C/C++ version of the product. 

## Requirements
- **Jetraw installed** on a Windows computer (MacOS and Linux coming soon) and installation folder in PATH (if not pass installation folder of jetraw_tiff library manually keeping installation folder structure).
- For writing compressed files a **valid License** is needed. 

## Installation
Download the Matlab Toolbox installer (.mltbx file) for the [latest (pre-)release](https://github.com/Jetraw/Jetraw-Matlab-Toolbox/releases). Once downloaded you simply need to double click on it and the installation process will start automatically. 

## Testing
The user can test that the installation was successful running the two set of tests available in this same GitHub repository. Go to the **folder "test"** and 
you will find the following tests:

- JetrawTiffWriterTest.m 
- JetrawTiffReaderTest.m 

In order to **run these tests** you simply need to type the following command:

```matlab
result = run(JetrawTiffWriterTest)
result = run(JetrawTiffReaderTest)
```

All tests should pass. 
**Remember** to copy the example image **example_image.p.tif** inside the test folder before running the tests. 

## Usage
If you want to get a list of all **available functions and features**, please execute the following command in your Matlab terminal:

```matlab
    help JetrawTiff
```

Here are some **code snippets** of how the module would typically be used. 

You can find a copy of this example in the **folder "example"** (exampleScrip.m) along with an
already Jetraw compressed TIFF image.

```matlab
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
```

## Contact
Feel free to use the [issues section](https://github.com/Jetraw/Jetraw-Matlab-Toolbox/issues) to report bugs or request new features. You can also ask questions and give comments by visiting the [discussions](https://github.com/Jetraw/Jetraw-Matlab-Toolbox/discussions), or following the contact information at https://jetraw.com.
