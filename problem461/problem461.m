function  M=problem461(N)
s=floor(log(pi+1)*N);
A=zeros(1,(s+1)*s/2);
C=zeros(2,(s+1)*s/2);
tic
t=1;
for a=1:floor(s*log(pi/3+1)/log(pi+1))
    b=a:s;
    A(t:t+s-a) = exp(a/N)+exp(b/N)-2;
    
    C(:,t:t+s-a) = [a*ones(1,length(b));b];
    t=t+s-a+1;
    
end
I=A>0;
A=A(I);
C=C(:,I);

I=A<pi;
A=A(I);
C=C(:,I);
[A,I]=sort(A);
C=C(:,I);
Areverse=fliplr(A);
error=5;
Amarker=1;
L=length(A);
for j=1:L/2
    if Amarker < L/2
        m=abs(A(j)+Areverse(Amarker)-pi);
        m2=abs(A(j)+Areverse(Amarker+1)-pi);
        while (m2 < m)
            Amarker=Amarker+1;
            m=m2;
            m2=abs(A(j)+Areverse(Amarker+1)-pi);
        end
        if m < error
            error=m;
            a = C(1,j);
            b = C(2,j);
            c = C(1,length(A)-Amarker+1);
            d = C(2,length(A)-Amarker+1);
            
        end
    end
end

M=a^2+b^2+c^2+d^2;
disp(a);
disp(b);
disp(c);
disp(d);
disp(a^2+b^2+c^2+d^2);
toc
end