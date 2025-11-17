#ifdef __INTELLISENSE__
#include "../common/common.module.cpp"
#endif

module;
#include <print>
#include <cereal/cereal.hpp>
import common;
export module hello;
 
export void hello() {
    const string str = "Hello From a Module!\n";
    std::println("{}", str);
}