#include <cstdint>
#include <string>

#include <memory>
#include <utility>

#include <array>
#include <vector>
#include <queue>
#include <map>
#include <unordered_map>

#include <optional>
#include <utility>

#include <print>
#include "hello/hello.h"
#include "fastnoise/FastNoiseLite.h"

//export {
    using int8 = std::int8_t;
    using int16 = std::int16_t;
    using int32 = std::int32_t;
    using int64 = std::int64_t;
    using uint8 = std::uint8_t;
    using uint16 = std::uint16_t;
    using uint32 = std::uint32_t;
    using uint64 = std::uint64_t;
    
    using std::unique_ptr;
    using std::shared_ptr;
    using std::make_unique;
    using std::make_shared;
    
    using String = std::string;
    using std::array;
    using std::vector;
    using std::queue;
    using std::map;
    using std::unordered_map;

    using std::optional;
    using std::pair;
    using std::swap;
    using std::move;
    using std::forward;
//}

//export namespace stdx   {
    using stdx::hello;
    using stdx::cxxversion;
//}