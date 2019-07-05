%function WS = mwatershed(F)

F=single(F);
fprintf("Открытие с реконструкцией...\n");
se = strel('cube',3);
Ie = F;%imerode(F,se);
Iobr = Ie;%imreconstruct(Ie,F);
fprintf("Закрытие с реконструкцией и дополнением...\n");
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fprintf("Определение локальных максимумов...\n");
fgm = imregionalmax(Iobrcbr);
fprintf("Дополнительная морфологическая обработка...\n");
se2 = strel(ones(3,3));
fgm2 = imclose(fgm,se2);
fgm3 = fgm2;%imerode(fgm2,se2);
fgm4 = bwareaopen(fgm3,20);
fprintf("Определение границ водораздела (поиск скелетона)...\n");
bw = imbinarize(Iobrcbr);
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
fprintf("Сегментация по методу водораздела...\n");
gmag2 = imimposemin(F, bgm | fgm4);
WS = watershed(gmag2);