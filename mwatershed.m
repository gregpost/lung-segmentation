%function WS = mwatershed(DT,F)

fprintf("Открытие с реконструкцией...\n");
se = strel('cube',15);
Ie = DT;%imerode(DT,se);
Iobr = Ie;%imreconstruct(Ie,DT);
fprintf("Закрытие с реконструкцией и дополнением...\n");
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fprintf("Определение локальных максимумов...\n");
fgm = imregionalmax(Iobrcbr);
fprintf("Дополнительная морфологическая обработка...\n");
se2 = strel(ones(5,5));
fgm2 = imclose(fgm,se2);
fgm3 = fgm2;%imerode(fgm2,se2);
fgm4 = bwareaopen(fgm3,20);
fprintf("Определение границ водораздела (поиск скелетона)...\n");
bw = imbinarize(Iobrcbr);
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
fprintf("Сегментация по методу водораздела...\n");
gmag2 = imimposemin(single(F), bgm | fgm4);
WS = watershed(gmag2);