#include <iostream>
int main() {int f_=1, f=1;int r=0;do {if (f%2==0) r+=f;int aux=f;f+=f_;f_=aux;} while (f<4e6);std::cout << "r=" << r << std::endl;}
