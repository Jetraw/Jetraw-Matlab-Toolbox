classdef JetrawTiffReaderTest < matlab.unittest.TestCase
    methods(Test)
        function testLoadLibAndOpenTiff(testCase)
            tif = JetrawTiff('example_image.p.tif','r');
            % verify tif properties 
            testCase.verifyEqual(tif.width(), 256);
            testCase.verifyEqual(tif.height(), 256);
            testCase.verifyEqual(tif.pages(), 100);
            testCase.verifyEqual(tif.pixelType(), 'uint16');
            tif.close();
        end
        
        function testReadSinglePage(testCase)
            tif = JetrawTiff('example_image.p.tif','r');
           
            % verify dimensions using image data
            imageStack = tif.readPage(0);
            [height, width, pages] = size(imageStack);
            testCase.verifyEqual(width, 256);
            testCase.verifyEqual(height, 256);
            testCase.verifyEqual(pages, 1);
            tif.close();
        end
        
        function testReadRangePages(testCase)
            tif = JetrawTiff('example_image.p.tif','r');
            
            % verify dimensions using image data
            imageStack = tif.readPage([4 10 50 90 99]);
            [height, width, pages] = size(imageStack);
            testCase.verifyEqual(width, 256);
            testCase.verifyEqual(height, 256);
            testCase.verifyEqual(pages, 5);
            tif.close();
        end
        
        function testReadAllPages(testCase)
            tif = JetrawTiff('example_image.p.tif','r');
            
            % verify dimensions using tif object
            testCase.verifyEqual(tif.width(), 256);
            testCase.verifyEqual(tif.height(), 256);
            testCase.verifyEqual(tif.pages(), 100);
            
            % verify dimensions using image data
            imageStack = tif.read();
            [height, width, pages] = size(imageStack);
            testCase.verifyEqual(width, 256);
            testCase.verifyEqual(height, 256);
            testCase.verifyEqual(pages, 100);
            tif.close();
        end
    end
end