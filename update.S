/*
 *  bdflush
 *
 *  Copyright (C) 1993  Hamish Coleman (hamish@zot.apana.org.au)
 *
 * Written in a fit of annoyance at the zillions of 'bdflush not running'
 * errors that appeared seconds after trying 1.1.4
 */

__NR_exit	= 1
__NR_fork	= 2
__NR_close	= 6
__NR_chdir	= 12
__NR_alarm	= 27
__NR_sync	= 36
__NR_brk	= 45
__NR_setsid	= 66
__NR_sigaction	= 67
__NR_sigsuspend	= 72
__NR_bdflush	= 134

SIGALRM		= 14
NULL		= 0
OPEN_MAX	= 0xff

error_none	= 0
error_update	= 1

.globl	_entry

_entry:

/* chdir("/"); */
	movl	$rootd,%ebx
	movl	$__NR_chdir,%eax
	int	$0x80
	
/* for (i=0;i<OPEN_MAX;i++) close(i); */
	movl	$OPEN_MAX,%ecx
1:	movl	%ecx,%ebx
	movl	$__NR_close,%eax
	int	$0x80
	loop	1b

/* setsid(); */
	movl	$__NR_setsid,%eax
	int	$0x80

/* if (fork()) return; */
	call	fork
	testl	%eax,%eax
	jle	1f
	movl	$error_none,%ebx
exit:
	movl	$__NR_exit,%eax
	int	$0x80
	jmp	exit


/* sigaction(SIGALRM, &sa); */
1:	movl	$SIGALRM,%ebx
	movl	$sa,%ecx
	movl	$NULL,%edx
	movl	$__NR_sigaction,%eax
	int	$0x80

/* alarm(30); */
	movl	$30,%ebx
	movl	$__NR_alarm,%eax
	int	$0x80

/* sigsuspend(NULL,NULL,NULL); */
	movl	$0,%ebx
	movl	$0,%ecx
	movl	$0,%edx
	movl	$__NR_sigsuspend,%eax
	int	$0x80

/*	movl	$__NR_sync,%eax	*/
/*	int	$0x80		*/
	
	movl	$1,%ebx
	call	bdflush

	jmp	1b

fork:
	movl	$__NR_fork,%eax
	int	$0x80
	ret
	
bdflush:
	movl	$NULL,%ecx
	movl	$__NR_bdflush,%eax
	int	$0x80
	ret

/* sigaction handler */
handler:
	ret

rootd:		.asciz	"/"
sa:		.long	handler
		.long	0
		.long	0
		.long	0
