TGT := kernel
OBJS := kernel.o

MAKEFLAGS += --no-builtin-rules

all: $(TGT)

$(TGT): $(OBJS)
	aarch64-linux-gnu-ld -nostdlib -Tlinker.ld -o $@ $^

%.o: %.c
	aarch64-elf-gcc -ffreestanding -c $< -o $@

%.o: %.s
	aarch64-linux-gnu-as -o $@ $<

clean:
	rm -f $(TGT) $(OBJS)
