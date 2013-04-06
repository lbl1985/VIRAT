bs = cv.BackgroundSubtractorMOG();

cam = cv.VideoCapture('11.mp4');
nFrame = cam.get('FrameCount');

progressbar('Learning Gaussian');
for i = 1 : nFrame
    frame = cam.read;
    if mod(i, 100) == 1
        fg = bs.apply(frame, 'LearningRate', 0.01);   
    end
    progressbar(i/nFrame);
end

cam = cv.VideoCapture('11.mp4');
for i = 1 : nFrame
    frame = cam.read;
    fg = bs.apply(frame, 'LearningRate', 0.001);
    fg_frame = frame;
    for j = 1 : 3
        fg_frame(:, :, j) = fg_frame(:, :, j) .* uint8(fg);
    end
    imshow(fg_frame);
    pause(1/22);
    
end