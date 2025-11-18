module;
#include <print>
#include "hello.h"
export module common:hello;

export namespace stdx   {
    using stdx::hello;
    using stdx::cxxversion;
}
