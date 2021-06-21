# matlabJetRaw, the Matlab module for JetRaw  

This is a Matlab toolbox to read and write (under development) TIFF files with JetRaw compression. For more info visit
https://www.jetraw.com/


## Requirements
- Jetraw installed on a Windows computer (MacOS and Linux coming soon) and installation folder in PATH (if not pass installation folder of jetraw_tiff library manually keeping installation folder structure).
- For writing compressed files a valid License is needed. 

## Usage
Here are some code snippets of how the module would typically be used. You can find a copy of this example in the folder "example" along with an
already Jetraw compressed TIFF image:
- exampleScript.m 

```matlab
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
tif = JetrawTiff('example_image.p.tif', 'r', 'path_to_jetrawtiff_lib');
imageStack = tif.read();
tif.close();
```

## Testing
The user can test that the installation was successful running the 2 tests available in this same GitHub repository. Go to the folder "test" and 
you will find the following tests:

- JetrawTiffWriterTest.m 
- JetrawTiffReaderTest.m 

In order to run these tests you simply need to type the following command:

result = run(JetrawTiffWriterTest)
result = run(JetrawTiffReaderTest)

All tests should pass. Remember to copy the example image "example_image.p.tif" inside the test folder before running the tests. 

## Contact

If you have any request or doubt please do not hesitate to contact us to:
https://dotphoton.com/contact
