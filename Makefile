CC=gcc
CFLAGS=-MMD

SRCS=$(wildcard src/*.c)
OBJS=$(SRCS:.c=.o)
DEPS=$(SRCS:.c=.d)

all: main

main: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

clean:
	rm -f src/*.o src/*.d main

-include $(DEPS)