/*
 *  true
 *
 *  Copyright (C) 1995  Hamish Coleman (hamish@zot.apana.org.au)
 *
 */

.globl	_entry


/*
 * This program is magic!
 *
 * in all the exec() man pages, it lies! - it says that exec
 * never returns.  Well, that is wrong, exec returns to the
 * beginning of the newly loaded program, and it returns its
 * result - a zero for success.
 *
 * The libc exit() code is more paranoid than me - it loops
 * infinitely, so if the syscall fails, it will indefinitely
 * retry it.  I think that if exit fails, then we are up shit
 * creek anyway, so why not have a good time while we are there
 * and run random code (0x00) until we hit the end of our code page,
 * and _then_ exit via a Seg-V  ( ;-P extra points awarded for
 * a description of what happens if the Seg-V fails to exit )
 */

_entry:
	mov	%eax,%ebx
	inc	%eax
	int	$0x80