COMPILER = g++
FLAGS = -std=c++23 -Wall -Wextra -fmodules-ts -O2
INCLUDE = 
SRC = src/hello/hello.module.cpp src/main.cpp
BINARY = Sandbox

ifeq ($(OS), Windows_NT)
	CLEAN = del $(BINARY).exe
else
	CLEAN = rm $(BINARY)
endif

build:
	$(COMPILER) $(FLAGS) $(SRC) -o $(BINARY)

run:
	./$(BINARY)

clean:
	$(CLEAN)

