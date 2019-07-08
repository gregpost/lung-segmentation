p1=zeros(12,1,'int32');
p2=zeros(12,1,'int32');
i=1;
for sigma=0.5:0.1:1.5
    F=getFissures2(V,L,sigma);
    p1(i)=sum(sum(sum(F&F2)));
    p2(i)=sum(sum(sum(F&~F2)));
    i=i+1;
end







p1=single(p1);
p2=single(p2);

s1=zeros(12,1,'single');
for i=1:11
    s1(i)=100-p1(i)/p1(i+1)*100;
end

s2=zeros(12,1,'single');
for i=1:11
    s2(i)=100-p2(i)/p2(i+1)*100;
end

s3=zeros(12,1,'single');
for i=1:11
    s3(i)=p2(i)/p1(i)*100;
end

i=1;
for sigma=0.5:0.1:1.5
    fprintf("%.2f; %.2f; %.2f; %.2f; %.2f; %.2f\n",sigma,p1(i),p2(i),s1(i),s2(i),s3(i));
    i=i+1;
end