#include <iostream>
int main() {int f_=2,f=8;int r=2;do {r+=f;int aux=f; f=4*f+f_;f_=aux;} while (f<4e6);std::cout << "r=" << r << std::endl;}
