/*
g++ generator.cpp -o generate.exe
./generate.exe 1 100
*/

#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

int main(int argc, char* argv[]) {
    srand(time(0));
    
    if(argc != 4) {
        cout << "Usage: " << argv[0] << " <min> <max> <count>" << endl;
        cout << "Example: " << argv[0] << " 1 100 3" << endl;
        return 1;
    }
    
    int min = atoi(argv[1]);
    int max = atoi(argv[2]);
    int count = atoi(argv[3]);
    
    if(min > max) {
        cout << "Error: min cannot be greater than max" << endl;
        return 1;
    }
    
    for(int i = 0; i < count; i++) {
        int random_num = min + rand() % (max - min + 1);
        cout << random_num << endl;
    }
    
    return 0;
}