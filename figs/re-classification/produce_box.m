addpath ../export_fig;

load preclass.mat;
fid = fopen('synset_words.txt');
tline = fgetl(fid);
synset_words{1} = tline;
while ischar(tline)
    disp(tline)
    tline = fgetl(fid);
    synset_words{end+1} = tline;
end
synset_words = synset_words(1:end-1);
fclose(fid);

imlist = dir('*.jpeg');
for i = 1:numel(imlist)
    im = imread(imlist(i).name);
    clf; imagesc(im); axis image; axis off; hold on;
    for n = 1:5
        x1 = preclass{i}.region{n}(1);
        y1 = preclass{i}.region{n}(2);
        x2 = preclass{i}.region{n}(3);
        y2 = preclass{i}.region{n}(4);
        if n ==1
            line([x1, x1, x2, x2, x1], [y1, y2, y2, y1, y1], 'Color', 'r', 'linewidth', 8)
            im2 = im(y1:y2,x1:x2,:);
            imwrite(im2,['crop_image/' imlist(i).name]); 
        else
            line([x1, x1, x2, x2, x1], [y1, y2, y2, y1, y1], 'Color', 'g', 'linewidth', 4, 'linestyle', '--')
        end
    end
    hold off;
    export_fig(['boundingbox/' imlist(i).name])
end