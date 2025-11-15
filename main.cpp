#include <iostream>
#include <string>

int main(int argc, char* argv[]) {
    std::cout << "Hello, Test Project!" << std::endl;
    
    if (argc > 1) {
        std::cout << "Arguments received: ";
        for (int i = 1; i < argc; ++i) {
            std::cout << argv[i] << " ";
        }
        std::cout << std::endl;
    }
    
    return 0;
}