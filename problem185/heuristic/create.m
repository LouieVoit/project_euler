M = zeros(6,6);
for i=1:6
    ind = (i-1)*16+1;
    aux = a(ind:ind+4);
    M(i,1:5) =  int2vec(str2double(aux),5);
    M(i,6) =str2double(a(ind + 7));
end