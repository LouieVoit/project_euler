function v = int2vec(s,l)

%INT2VEC Convert integer to vector.
%
%  Function call v=int2vec(s,l) 
%  s is the integer to be converted.
%  l is the length of the integer in bits.
%  For example v=int2vec(110,3) returns v=[1 1 0].
%
%  See also DEC2BIN, STR2NUM.
%
%  Copyright (c) 2005 by Jim Simos , email:jsimos@math.uoa.gr
%  $Revision : 1.0 $  $Date: 21/8/2005 20:30:20 PM $

%-----Begin Function-----%

% Initializing variables

b=-1;
v=[];

% Check that appropriate argument is given

if s<0,
    error('Give positive integer');
end

%----Main function-----%


while b~=0,
   a=rem(s,10); 
   b=fix(s/10);   
   v=[a,v];  
   s=b;  
end

% If the first bits of the codeword are 
% zero fix can't place the zero bit in b

if length(v)~=l,
    v=[zeros(1,abs(l-length(v))),v];
end

% If the length of the codeword exceeds
% the 17 bits bugs may appear in the last 
% bit due to roundoff errors

if length(v)>=17,
   warning('Bug may appear for codewords with length greater than 17 bits');    
end

    

%-----End Function-----%





   
   
   