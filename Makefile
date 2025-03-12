CC=gcc
CFLAGS=-c
DEPFLAGS=-MM

SRCS=$(wildcard src/*.c)
OBJS=$(SRCS:.c=.o)
DEPS=$(SRCS:.c=.d)

# n.b. put this at the top so that it's the deafult
# target. Otherwise the top level target gets
# automatically called by Nix mkDerivation
deps: $(DEPS)
	@echo "Dependencies generated"

all: main

main: $(OBJS)
	$(CC) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.d: %.c
	$(CC) -MM $< > $@

clean:
	rm -f src/*.o src/*.d main

.PHONY: all clean deps

-include $(DEPS)