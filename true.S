/*
 *  true
 *
 *  Copyright (C) 1995  Hamish Coleman (hamish@zot.apana.org.au)
 *
 */

__NR_exit	= 1

error_true	= 0
error_false	= 1

.globl	_entry

_entry:

exit:
	movl	$__NR_exit,%eax
	movl	$error_true,%ebx
	int	$0x80
	jmp	exit

