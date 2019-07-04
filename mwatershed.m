%function WS = mwatershed(V)

V=DTB1(:,:,200:400);
fprintf("Открытие с реконструкцией...\n");
se = strel('cube',10);
Ie = imerode(V,se);
Iobr = imreconstruct(Ie,V);
fprintf("Закрытие с реконструкцией и дополнением...\n");
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fprintf("Определение локальных максимумов...\n");
fgm = imregionalmin(Iobrcbr);
fprintf("Дополнительная морфологическая обработка...\n");
se2 = strel(ones(5,5));
fgm2 = imclose(fgm,se2);
fgm3 = imerode(fgm2,se2);
fgm4 = bwareaopen(fgm3,20);
fprintf("Определение границ водораздела...\n");
bw = imbinarize(Iobrcbr);
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
fprintf("Сегментация по методу водораздела...\n");
gmag2 = imimposemin(V, bgm | fgm4);
WS = watershed(gmag2);