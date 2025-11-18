#include "intellisense.hpp"
#include <print>
import common;

//INCLUDE =  -I$(INCLUDEPATH)/cereal/1.3.2/include
//-I$(INCLUDEPATH)/spdlog/1.16.0/Release/x86_64/include/spdlog

int main() {
    std::println("Compiled with: {}", stdx::cxxversion());
    stdx::hello();
    return 0;
}