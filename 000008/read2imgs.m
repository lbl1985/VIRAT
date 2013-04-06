function read2imgs(filename)
cam = cv.VideoCapture(filename);
saveFolder = fullfile('/Users/herbert19lee/Desktop/label', 'images');
for i = 1 : 100    
    frame = cam.read;
    if mod(i, 3) == 1
        imwrite(frame, fullfile(saveFolder, ['img_' num2str2(i, 5) '.jpg']));
    end
end