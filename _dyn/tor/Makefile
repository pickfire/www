CC     := cc
CFLAGS := -O2 -march=native

SRC = $(wildcard *.c)
OUT = $(SRC:.c=)

%: %.c
	$(CC) $< -o $@ $(CFLAGS)

all: $(OUT)

clean:
	rm $(OUT)

.PHONY = all clean
