/*
 *  false
 *
 *  Copyright (C) 1995  Hamish Coleman (hamish@zot.apana.org.au)
 *
 */

.globl	_entry

_entry:
	inc	%eax
	mov	%eax,%ebx
	int	$0x80
