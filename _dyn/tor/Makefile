CC     := cc
CFLAGS := -O2 -march=native

SRC = torcheck.c update.c
OUT = $(SRC:.c=)

%: %.c
	$(CC) $< -o $@ $(CFLAGS)

all: $(OUT) check.cgi

clean:
	rm $(OUT)

check.cgi: check.c
	$(CC) $< -o $@ $(CFLAGS) -lfcgi

.PHONY = all clean
