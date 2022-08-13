TGT := kernel

MAKEFLAGS += --no-builtin-rules

all: $(TGT)

$(TGT): kernel.o
	aarch64-linux-gnu-ld -nostdlib -Tlinker.ld -o $@ $^

%.o: %.c
	aarch64-elf-gcc -ffreestanding -c $< -o $@

%.o: %.s
	aarch64-linux-gnu-as -o $@ $<
