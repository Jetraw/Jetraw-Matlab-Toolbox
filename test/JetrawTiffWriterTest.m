classdef JetrawTiffWriterTest < matlab.unittest.TestCase
    methods(Test)
        function testWriteSinglePage(testCase)
            tifRead = JetrawTiff('example_image.p.tif','r');
            % verify dimensions using image data
            imageStack = tifRead.read();
            tifRead.close();
            
            % write single image
            tifWrite = JetrawTiff('test_write.p.tif', 'w');
            tifWrite.write(imageStack(:, :, 1));
            tifWrite.close();
            
            % read again
            clear imageStack;
            tifRead = JetrawTiff('test_write.p.tif','r');
            % verify dimensions using image data
            imageStack = tifRead.read();
            [height, width, pages] = size(imageStack);
            testCase.verifyEqual(width, 256);
            testCase.verifyEqual(height, 256);
            testCase.verifyEqual(pages, 1);
            tifRead.close();
        end
        
        function testWriteMultiPage(testCase)
            tifRead = JetrawTiff('example_image.p.tif','r');
            % verify dimensions using image data
            imageStack = tifRead.read();
            tifRead.close();
            
            % write multipage image
            tifWrite = JetrawTiff('test_write.p.tif', 'w');
            tifWrite.write(imageStack);
            tifWrite.close();
            
            % read again
            clear imageStack;
            tifRead = JetrawTiff('test_write.p.tif','r');
            % verify dimensions using image data
            imageStack = tifRead.read();
            [height, width, pages] = size(imageStack);
            testCase.verifyEqual(width, 256);
            testCase.verifyEqual(height, 256);
            testCase.verifyEqual(pages, 100);
            tifRead.close();
        end
    end
end