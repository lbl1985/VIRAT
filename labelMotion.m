function labelMotion(root, vsId, fsId)
% vsId: video start Id
% fsId: frame start Id

nType = 3;
color = varycolor(nType);
saveFolder = fullfile(root, 'motSave');
checkFolder(saveFolder);

[src filenames n] = rfdatabase(fullfile(root, 'motion_label'), [], '.mat');
for i = vsId : n
    display(filenames{i});
    load(fullfile(src, filenames{i})); % load frameAnt
    breakPos = strfind(filenames{i}, '_motion');
    folderName = filenames{i}(1:breakPos - 1);
    [srcImg, imgNames, m] = rfdatabase(fullfile(root, folderName, 'extract_11'), [], '.jpg');
    for j = 19+fsId : length(frameAnt)
        imshow(fullfile(srcImg, imgNames{j}));
        title(['Frame ' num2str(j)]);
        for k = 1 : nType
            tmp = frameAnt{j}{k};
            if ~isempty(tmp) %&& isfield(tmp(1), 'mot')
                for p = 1 : length(tmp)
                    tmpPos = tmp(p).pos;
                    tmpMot = tmp(p).mot;
                    hp = impoly(gca, tmpPos);
                    setColor(hp, color(k, :));
                    [isCor smot] = promptMotionType(tmpMot);
                    if isCor
                       frameAnt{j}{k}(p).BW = [];
                    else
                       frameAnt{j}{k}(p).mot = smot;
                       frameAnt{j}{k}(p).BW = [];
                    end
                end
            end
        end
        % Save result every frame
        save(fullfile(saveFolder, filenames{i}), 'frameAnt', '-v7.3');
    end
end
end

function [isCorrect mot] = promptMotionType(tmpMot)
switch tmpMot
    case 1
        prompt = {'Is it motion STATIC? t/f', 'Or what? static-1 dec-2 acc-3 smooth -4'};
    case 2
        prompt = {'Is it motion Decelerate? t/f', 'Or what? static-1 dec-2 acc-3 smooth -4'};
    case 3
        prompt = {'Is it motion Accelerate? t/f', 'Or what? static-1 dec-2 acc-3 smooth -4'};
    case 4
        prompt = {'Is it motion Smooth? t/f', 'Or what? static-1 dec-2 acc-3 smooth -4'};
    otherwise
        prompt = {['Error Mot = ' num2str(tmpMot) ' is undefined'], 'ERROR'};
end
dlg_title = 'Motion label';
num_lines = 2;
def = {'t', '1'};
answer = inputdlg(prompt, dlg_title, num_lines, def);
isCorrect = isequal(answer{1}, 't');
mot = str2double(answer{2});
end