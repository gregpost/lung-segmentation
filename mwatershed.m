%function WS = mwatershed(F)

F=single(F);
fprintf("�������� � ��������������...\n");
se = strel('cube',3);
Ie = F;%imerode(F,se);
Iobr = Ie;%imreconstruct(Ie,F);
fprintf("�������� � �������������� � �����������...\n");
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fprintf("����������� ��������� ����������...\n");
fgm = imregionalmax(Iobrcbr);
fprintf("�������������� ��������������� ���������...\n");
se2 = strel(ones(3,3));
fgm2 = imclose(fgm,se2);
fgm3 = fgm2;%imerode(fgm2,se2);
fgm4 = bwareaopen(fgm3,20);
fprintf("����������� ������ ����������� (����� ���������)...\n");
bw = imbinarize(Iobrcbr);
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
fprintf("����������� �� ������ �����������...\n");
gmag2 = imimposemin(F, bgm | fgm4);
WS = watershed(gmag2);