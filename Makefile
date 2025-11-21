COMPILER = g++
FLAGS = -std=c++23 -Wall -Wextra -fmodules-ts -O2
INCLUDE = -DSPDLOG_FMT_EXTERNAL -I"./lib/include/"
LINKER = -L"./lib/lib/"
LIBS = -lspdlog -lfmt
BUILD = bin
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

build: $(BINARY)

$(BINARY): $(BUILD)/types.o $(BUILD)/hello.o $(BUILD)/hello.module.o $(BUILD)/common.module.o $(BUILD)/main.o
	$(COMPILER) $(FLAGS) $(LINKER) $^ $(LIBS) -o $@

$(BUILD)/types.o: $(SRC)/types/types.module.cpp | $(BUILD)
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $< -o $@

$(BUILD)/hello.o: $(SRC)/hello/hello.cpp | $(BUILD)
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $< -o $@

$(BUILD)/hello.module.o: $(SRC)/hello/hello.module.cpp | $(BUILD)
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $< -o $@

$(BUILD)/common.module.o: $(SRC)/common.module.cpp | $(BUILD)
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $< -o $@

$(BUILD)/main.o: src/main.cpp | $(BUILD)
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $< -o $@

$(BUILD):
	mkdir -p $(BUILD)

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