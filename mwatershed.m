%function WS = mwatershed(V)

V=DTB1(:,:,200:400);
fprintf("�������� � ��������������...\n");
se = strel('cube',10);
Ie = imerode(V,se);
Iobr = imreconstruct(Ie,V);
fprintf("�������� � �������������� � �����������...\n");
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fprintf("����������� ��������� ����������...\n");
fgm = imregionalmin(Iobrcbr);
fprintf("�������������� ��������������� ���������...\n");
se2 = strel(ones(5,5));
fgm2 = imclose(fgm,se2);
fgm3 = imerode(fgm2,se2);
fgm4 = bwareaopen(fgm3,20);
fprintf("����������� ������ �����������...\n");
bw = imbinarize(Iobrcbr);
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
fprintf("����������� �� ������ �����������...\n");
gmag2 = imimposemin(V, bgm | fgm4);
WS = watershed(gmag2);