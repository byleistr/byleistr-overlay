
totally_ubuntu.so: totally_ubuntu.c
	gcc -fPIC -shared -ldl -Wl,-soname,totally-ubuntu.so -o totally_ubuntu.so totally_ubuntu.c

all: totally_ubuntu.so
