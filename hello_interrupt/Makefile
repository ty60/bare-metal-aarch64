TGT := kernel
OBJS := vectors.o main.o start.o

CFLAGS := -O2
MAKEFLAGS += --no-builtin-rules

all: $(TGT)

$(TGT): $(OBJS)
	aarch64-linux-gnu-ld -nostdlib -Tlinker.ld -o $@ $^

%.o: %.c
	aarch64-linux-gnu-gcc $(CFLAGS) -ffreestanding -c $< -o $@

%.o: %.s
	aarch64-linux-gnu-as -o $@ $<

clean:
	rm -f $(TGT) $(OBJS)
