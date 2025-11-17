COMPILER = g++
FLAGS = -std=c++23 -Wall -Wextra -fmodules-ts -O2
INCLUDEPATH = build/conan/full_deploy/host
INCLUDE = -I$(INCLUDEPATH)/cereal/1.3.2/include
SRC = src/common/common.module.cpp src/hello/hello.module.cpp src/main.cpp
BINARY = build/Sandbox

ifeq ($(OS), Windows_NT)
	CLEAN = del /Q
	BINARY_EXT = .exe
else
	CLEAN = rm -rf
	BINARY_EXT =

endif

.PHONY: build run install clean clean-modules clean-libs clean-all

build:
	$(COMPILER) $(FLAGS) $(INCLUDE) $(SRC) -o $(BINARY)

run:
	./$(BINARY)

install:
	conan install . --output-folder=build/conan --build=missing --deployer=full_deploy

clean:
	$(CLEAN) $(BINARY) $(BINARY_EXT)

clean-modules:
	$(CLEAN) gcm.cache

clean-libs:
	$(CLEAN) build/conan

clean-all:
	$(CLEAN) $(BINARY)
	$(CLEAN) gcm.cache
	$(CLEAN) build/conan