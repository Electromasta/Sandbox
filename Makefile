COMPILER = g++
FLAGS = -std=c++23 -Wall -Wextra -fmodules-ts -O2
BUILD = build
INCLUDEPATH = $(BUILD)/conan/full_deploy/host
SRC= src/common
BINARY = $(BUILD)/Sandbox

ifeq ($(OS), Windows_NT)
	CLEAN = del /Q
	BINARY_EXT = .exe
else
	CLEAN = rm -rf
	BINARY_EXT =

endif

.PHONY: build run install clean clean-modules clean-libs clean-all

build:
	$(COMPILER) $(FLAGS) -c $(SRC)/types/types.module.cpp -o $(BUILD)/types.o
	$(COMPILER) $(FLAGS) -c $(SRC)/hello/hello.cpp -o $(BUILD)/hello.o
	$(COMPILER) $(FLAGS) -c $(SRC)/hello/hello.module.cpp -o $(BUILD)/hello.module.o
	$(COMPILER) $(FLAGS) -c $(SRC)/common.module.cpp -o $(BUILD)/common.module.o
	$(COMPILER) $(FLAGS) -c src/main.cpp -o $(BUILD)/main.o
	$(COMPILER) $(FLAGS) $(BUILD)/types.o $(BUILD)/hello.o $(BUILD)/hello.module.o $(BUILD)/common.module.o $(BUILD)/main.o -o $(BINARY)

run:
	./$(BINARY)$(BINARY_EXT)

install:
	conan install . --output-folder=build/conan --build=missing --deployer=full_deploy

clean:
	$(CLEAN) $(BINARY)$(BINARY_EXT)
	$(CLEAN) $(BUILD)/*.o

clean-modules:
	$(CLEAN) gcm.cache

clean-libs:
	$(CLEAN) build/conan

clean-all:
	$(CLEAN) $(BINARY)
	$(CLEAN) gcm.cache
	$(CLEAN) build/conan