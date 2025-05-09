all: bin/boot.bin

bin/boot.bin: src/boot.S
	nasm -f bin src/boot.S -o bin/boot.bin

run: bin/boot.bin
	qemu-system-x86_64 -drive format=raw,file=bin/boot.bin

clean:
	rm -rf bin/*.bin


