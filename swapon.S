/*
 * Build using:
 *
 *	gcc -c pwd.S 
 *	ld pwd.o -o pwd.tmp
 *	objcopy --strip-all -R .data -R .bss pwd.tmp pwd
 */

_start:
	movl	$87,%eax
	movl	$file,%ebx
	movl	$0,%ecx
	int	$0x80

	movl	%eax,%ebx
	movl	$1,%eax
	int	$0x80


file:	.asciz	"/dev/sdb1"


