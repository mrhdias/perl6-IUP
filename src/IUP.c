/*
 * 
 * cc -o IUP.o -fPIC -c IUP.c
 * cc -shared -s -o IUP.so IUP.o
 * rm IUP.o
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iup.h>

#ifdef WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

DLLEXPORT Icallback IupTakeACallback(Icallback (*cb)(void)) {
	return (Icallback)cb();
}
