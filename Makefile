COMPILER = g++
FLAGS = -std=c++20 -Wall -Wextra -O2
INCLUDE = 
SRC = main.cpp
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

