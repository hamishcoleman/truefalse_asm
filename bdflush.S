/*
 *  bdflush
 *
 *  Copyright (C) 1993  Hamish Coleman (hamish@zot.apana.org.au)
 *
 * Written in a fit of annoyance at the zillions of 'bdflush no running'
 * errors that appeared seconds after trying 1.1.4
 */

__NR_bdflush	= 134
__NR_exit	= 1

.globl	_entry
_entry:
	movl	$__NR_bdflush,%eax
	movl	$0,%ebx
	movl	$0,%ecx
	int	$0x80
	movl	$__NR_exit,%eax
	movl	$1,%ebx
	int	$0x80
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
