SRC = $(wildcard src/*.cpp src/*/*.cpp src/*/*/*.cpp src/*/*/*/*.cpp)
LIBRARY = lib
CACHE = gcm.cache
BUILD = bin
BINARY = $(BUILD)/Sandbox

OBJDIR = obj
OBJ = $(patsubst src/%.cpp,$(OBJDIR)/%.o,$(SRC))

COMPILER = g++
FLAGS = -std=c++23 -Wall -Wextra -Wno-misleading-indentation -fmodules-ts -O2
INCLUDE = -DSPDLOG_FMT_EXTERNAL -I"./$(LIBRARY)/include/"
LINKER = -L"./$(LIBRARY)/lib/" -lspdlog -lfmt

ifeq ($(OS), Windows_NT)
	CLEAN = del /Q
	BINARY_EXT = .exe
else
	CLEAN = rm -rf
	BINARY_EXT =

endif

.PHONY: build run install clean clean-modules clean-libs clean-all

build: $(BINARY)

$(BINARY): $(OBJ)
	@mkdir -p $(BUILD)
	$(COMPILER) $(FLAGS) $(OBJ) $(LINKER) -o $(BINARY)

$(OBJDIR)/%.o: src/%.cpp
	@mkdir -p $(dir $@)
	$(COMPILER) $(FLAGS) $(INCLUDE) -c $< -o $@

run:
	./$(BINARY)$(BINARY_EXT)

install:
	conan install . --output-folder=conan --build=missing --deployer=full_deploy
	mkdir -p $(LIBRARY)/include $(LIBRARY)/lib
	mv conan/full_deploy/host/*/*/include/* $(LIBRARY)/include
	mv conan/full_deploy/host/*/*/*/*/include/* $(LIBRARY)/include
	mv conan/full_deploy/host/*/*/*/*/lib/* $(LIBRARY)/lib
	$(CLEAN) conan

clean:
	$(CLEAN) $(BINARY)$(BINARY_EXT)
	$(CLEAN) $(BUILD)/*.o

clean-modules:
	$(CLEAN) $(OBJDIR)
	$(CLEAN) $(CACHE)

clean-libs:
	$(CLEAN) $(LIBRARY)

clean-all:
	$(CLEAN) $(BINARY)$(BINARY_EXT)
	$(CLEAN) $(BUILD)/*.o
	$(CLEAN) $(CACHE)
	$(CLEAN) $(LIBRARY)