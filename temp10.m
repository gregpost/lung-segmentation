p1=zeros(15,1,'single');
p2=zeros(15,1,'single');
i=1;
for tr=-30:3:9
    F=getFissures3(V,L,1,tr,30,30);
    p1(i)=sum(sum(sum(F&F2)));
    p2(i)=sum(sum(sum(F&~F2)));
    i=i+1;
end




p1=single(p1);
p2=single(p2);

s1=zeros(15,1,'single');
for i=1:14
    s1(i)=100-p1(i)/p1(i+1)*100;
end

s2=zeros(15,1,'single');
for i=1:14
    s2(i)=100-p2(i)/p2(i+1)*100;
end

s3=zeros(15,1,'single');
for i=1:15
    s3(i)=p2(i)/p1(i)*100;
end

i=1;
for tr=-30:3:9    
    fprintf("%.2f; %.2f; %.2f; %.2f; %.2f; %.2f\n",tr,p1(i),p2(i),s1(i),s2(i),s3(i));
    i=i+1;
end