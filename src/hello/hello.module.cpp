module;
#include <iostream>
#include <cereal/cereal.hpp>
export module hellomodule;
 
export void hello() {
    std::cout << "Hello From a Module!\n";
}