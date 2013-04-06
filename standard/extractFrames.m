function extractFrames(lab)
savingFolder = './ExtractFrames';
sourceFolder = './orgFrames';
key = lab(:, 1);
key = [key - 3 key key + 3];
key = key';
key = key(:);
for i = numel(key)
    frame =  imread(fullfile(sourceFolder, ['img_' num2str2(key(i), 5) '.jpg']));
    imwrite(frame, fullfile(savingFolder, ['img_' num2str2(key(i), 5) '.jpg']));
end