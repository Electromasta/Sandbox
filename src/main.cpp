#include "intellisense.hpp"
#include <print>
import common;

int main() {
    std::println("Compiled with: {}", stdx::cxxversion());
    stdx::hello();
    return 0;
}