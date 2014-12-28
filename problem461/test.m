n=10000;
ebest=1e-8;
maxf=pi+ebest;
format long g
tic
maxa=floor(log(maxf+1)*n)
fn=exp((0:maxa)/n)-1;
b=[maxa:-1:0];
fb=fn(b+1);
maxb=min(b,floor(log(maxf-fb+1)*n));
f2=zeros(sum(maxb)+maxa,1);
r=0;
for a=maxa:-1:0
    maxba=maxb(maxa-a+1);
    fa=fn(a+1);
    f2(r+1:r+maxba+1)=(fa+fb(maxa-maxba+1:end));
    r=r+maxba;
end
f2=sort(f2);
disp('f2 generated')
j=1;
for i=length(f2):-1:1;
    while (f2(i)+f2(j))<(pi+ebest) && i>=j
        if abs(f2(i)+f2(j)-pi)<ebest
            ebest=abs(f2(i)+f2(j)-pi)
            minfij=[f2(i) f2(j)];
        end
        j=j+1;
    end
end
s=0;
for a=maxa:-1:0
    maxba=maxb(maxa-a+1);
    fa=fn(a+1);
    f2add=(fa+fb(maxa-maxba+1:end));
    r=find(f2add==minfij(1));
    if ~isempty(r)
        s=s+a^2+b(maxa-maxba+r)^2;
    end
    r=find(f2add==minfij(2));
    if ~isempty(r)
        s=s+a^2+b(maxa-maxba+r)^2;
    end
end
s
t=toc