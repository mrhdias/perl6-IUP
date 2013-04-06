#
# The only purpose of this Makefile is make tests.
#
# libiup.so
# libiupimglib.so
#

DEBUG=0

ifeq ($(DEBUG), 1)
$(info Building with debug option)
	CFLAGS=-DDEBUG
else
	CFLAGS=-DNDEBUG
endif

CC = cc $(CFLAGS)

all: IUP.o IUP.so

IUP.o:
	$(CC) -fPIC -o IUP.o -c IUP.c

IUP.so:
	cc -liup -liupimglib -shared -s -o IUP.so IUP.o

install:
	cp IUP.so ../lib/IUP.so

clean:
	rm IUP.so IUP.o

mrproper: clean
