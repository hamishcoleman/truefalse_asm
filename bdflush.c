/*
 * A simple bdflush daemon
 *
 * Written by Hamish Coleman because he found that his brand new kernel
 * was spewing zillions of 'bdflush not running' messages
 *
 */
 
#include <linux/unistd.h>

_syscall2(int,bdflush,int,func,int,data)

main() {
	return bdflush(0,0);
}
