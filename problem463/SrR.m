function [ res ] = SrR( n )
global arr;
if (n==1)
    res = 1;
elseif (n==2)
    res = 2;
elseif (n==3)
    res = 5;
elseif (n<=0)
    res =0;
elseif(mod(n,4) == 0)
    q = n/4;
    i1 = find(arr(:,2)==2*q-1);
    if ~isempty(i1)
        val1 = arr(i1,1);
    else
        val1=SrR(2*q-1);
        [n,~]=size(arr);
        arr(n+1,1)=val1;
        arr(n+1,2)=2*q-1;
    end
    i2 = find(arr(:,2)==q-1);
    if ~isempty(i2)
        val2 = arr(i2,1);
    else
        val2=SrR(q-1);
        [n,~]=size(arr);
        arr(n+1,1)=val2;
        arr(n+1,2)=q-1;
    end 
    i3 = find(arr(:,2)==q);
    if ~isempty(i3)
        val3 = arr(i3,1);
    else
        val3=SrR(q);
        [n,~]=size(arr);
        arr(n+1,1)=val3;
        arr(n+1,2)=q;
    end 
%     res = -1 + 6*SrR(2*q-1) - 9*SrR(q-1)+ SrR(q);
    res = -1 + 6*val1 - 9*val2+ val3;
elseif (mod(n-1,4) == 0)
    q = (n-1)/4;
    i4 = find(arr(:,2)==2*q+1);
    if ~isempty(i4)
        val4 = arr(i4,1);
    else
        val4=SrR(2*q+1);
        [n,~]=size(arr);
        arr(n+1,1)=val4;
        arr(n+1,2)=2*q+1;
    end
    i1 = find(arr(:,2)==2*q-1);
    if ~isempty(i1)
        val1 = arr(i1,1);
    else
        val1=SrR(2*q-1);
        [n,~]=size(arr);
        arr(n+1,1)=val1;
        arr(n+1,2)=2*q-1;
    end
    i3 = find(arr(:,2)==q);
    if ~isempty(i3)
        val3 = arr(i3,1);
    else
        val3=SrR(q);
        [n,~]=size(arr);
        arr(n+1,1)=val3;
        arr(n+1,2)=q;
    end 
    i2 = find(arr(:,2)==q-1);
    if ~isempty(i2)
        val2 = arr(i2,1);
    else
        val2=SrR(q-1);
        [n,~]=size(arr);
        arr(n+1,1)=val2;
        arr(n+1,2)=q-1;
    end  
%     res = -1 + 6*SrR(q-1) +2*SrR(2*q+1) +4*SrR(2*q-1) -2*SrR(q);
    res = -1 - 6*val2 +2*val4 +4*val1 -2*val3;

elseif (mod(n-2,4) == 0)
    q=(n-2)/4;
    i1 = find(arr(:,2)==2*q-1);
    if ~isempty(i1)
        val1 = arr(i1,1);
    else
        val1=SrR(2*q-1);
        [n,~]=size(arr);
        arr(n+1,1)=val1;
        arr(n+1,2)=2*q-1;
    end
    i2 = find(arr(:,2)==q-1);
    if ~isempty(i2)
        val2 = arr(i2,1);
    else
        val2=SrR(q-1);
        [n,~]=size(arr);
        arr(n+1,1)=val2;
        arr(n+1,2)=q-1;
    end 
    i3 = find(arr(:,2)==q);
    if ~isempty(i3)
        val3 = arr(i3,1);
    else
        val3=SrR(q);
        [n,~]=size(arr);
        arr(n+1,1)=val3;
        arr(n+1,2)=q;
    end 
    i4 = find(arr(:,2)==2*q+1);
    if ~isempty(i4)
        val4 = arr(i4,1);
    else
        val4=SrR(2*q+1);
        [n,~]=size(arr);
        arr(n+1,1)=val4;
        arr(n+1,2)=2*q+1;
    end
    %     res = -1- 3*SrR(q) +3*SrR(2*q+1) +3*SrR(2*q-1) -5*SrR(q-1);
    res = -1- 3*val3 +3*val4 +3*val1 -5*val2;
elseif (mod(n-3,4) == 0)
    q = (n-3)/4;
    i3 = find(arr(:,2)==q);
    if ~isempty(i3)
        val3 = arr(i3,1);
    else
        val3=SrR(q);
        [n,~]=size(arr);
        arr(n+1,1)=val3;
        arr(n+1,2)=q;
    end 
    i4 = find(arr(:,2)==2*q+1);
    if ~isempty(i4)
        val4 = arr(i4,1);
    else
        val4=SrR(2*q+1);
        [n,~]=size(arr);
        arr(n+1,1)=val4;
        arr(n+1,2)=2*q+1;
    end
%     res = -1 + 6*SrR(2*q+1) -8*SrR(q);
    res = -1 + 6*val4 -8*val3;
end
end

