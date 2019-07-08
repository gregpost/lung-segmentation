p1=zeros(15,1,'single');
p2=zeros(15,1,'single');
i=1;
for vy=5:5:50
    F=getFissures3(V,L,1,-6,vy,20);
    p1(i)=sum(sum(sum(F&F2)));
    p2(i)=sum(sum(sum(F&~F2)));
    i=i+1;
end

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
for vy=5:5:50  
    fprintf("%.2f; %.2f; %.2f; %.2f; %.2f; %.2f\n",vy,p1(i),p2(i),s1(i),s2(i),s3(i));
    i=i+1;
end