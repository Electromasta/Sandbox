//#include "intellisense.hpp"
#include <print>
//import common;
#include "common/common.module.cpp"

int main() {
    std::println("Compiled with: {}", stdx::cxxversion());
    std::println("Out Out Out");
    stdx::hello();
    int8 test = 8;
    FastNoiseLite noise;
    return 0;
}