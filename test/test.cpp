
class MyClass {

public:
   double toto(int i, float k, double l) {
    return i * k * l;
  }

};

int main() { 
   MyClass m;
   m.toto(1,2.0,3.0);
   return 0; }
