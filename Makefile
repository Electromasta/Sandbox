COMPILER = g++
FLAGS = -std=c++23 -Wall -Wextra -fmodules-ts -O2
BUILD = bin
INCLUDE = -DSPDLOG_FMT_EXTERNAL -I"./lib/include/"
LINKER = -L"./lib/lib/"
LIBS = -lspdlog -lfmt
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
	mkdir -p $(BUILD)
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $(SRC)/types/types.module.cpp -o $(BUILD)/types.o
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $(SRC)/hello/hello.cpp -o $(BUILD)/hello.o
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $(SRC)/hello/hello.module.cpp -o $(BUILD)/hello.module.o
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $(SRC)/common.module.cpp -o $(BUILD)/common.module.o
	$(COMPILER) $(FLAGS) $(INCLUDE) -c src/main.cpp -o $(BUILD)/main.o
	$(COMPILER) $(FLAGS) $(LINKER) $(BUILD)/types.o $(BUILD)/hello.o $(BUILD)/hello.module.o $(BUILD)/common.module.o $(BUILD)/main.o $(LIBS) -o $(BINARY)

run:
	./$(BINARY)$(BINARY_EXT)

install:
	conan install . --output-folder=conan --build=missing --deployer=full_deploy
	mkdir -p lib/include lib/lib
	mv conan/full_deploy/host/*/*/include/* lib/include
	mv conan/full_deploy/host/*/*/*/*/include/* lib/include
	mv conan/full_deploy/host/*/*/*/*/lib/* lib/lib
	$(CLEAN) conan

clean:
	$(CLEAN) $(BINARY)$(BINARY_EXT)
	$(CLEAN) $(BUILD)/*.o

clean-modules:
	$(CLEAN) gcm.cache

clean-libs:
	$(CLEAN) lib

clean-all:
	$(CLEAN) $(BINARY)
	$(CLEAN) gcm.cache
	$(CLEAN) lib