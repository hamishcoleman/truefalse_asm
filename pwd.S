/*

From apana.lists.os.linux.kernel Fri Apr  3 23:07:48 1998
Path: news.teragen.com.au!news2.melb.apana.org.au!goliath.apana.org.au!greathan.apana.org.au!gateway
From: torvalds@transmeta.com (Linus Torvalds)
Newsgroups: apana.lists.os.linux.kernel
Subject: Linux-2.1.92 - Feature Freeze
Date: 2 Apr 98 01:50:18 GMT
Organization: Mail-to-News Gateway
Lines: 78
Sender: daemon@gondor.apana.org.au
Approved: usenet@greathan.apana.org.au
Message-ID: <Pine.LNX.3.95.980401173959.1872A-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Authentication-Warning: penguin.transmeta.com: torvalds owned process doing -bs
X-Orcpt: rfc822;linux-kernel@vger.rutgers.edu
X-Loop: majordomo@vger.rutgers.edu
Xref: news.teragen.com.au apana.lists.os.linux.kernel:39260


Ok, there's a fairly large patch out there, but as of 2.1.92 I think we
have a real feature-freeze, and we'll try to get a real code-freeze going
soon. There are known problems with the sound drivers etc, which is why a
code-freeze isn't the best suggestion right now, and there are probably
still bugs with some of the new code, but I'll freeze new features for the
upcoming 2.2 kernel. 

Yes, some people will scream bloody murder, but others will be relieved
that it finally happened. Thanks especially to David Miller who has been
doing a great job of getting the TCP stack from its problems just a few
weeks ago to really shining new heights. That was my main worry about 2.2
not all that long ago, and was the main reason for having such a slushy
period for a while. 

2.1.92 does:
 - ISDN updates
 - alpha update (yes, SMP finally works, although not really stable yet)
 - networking fixes
 - "getcwd()" system call (not very long, the dcache makes this so
   trivial it is scary)
 - the mm responsiveness updates (they were in 2.1.92-pre2, people seemed
   to have found them very effective)
 - some other (mainly driver updates)

Please do test it all out. Feature-freeze doesn't mean that it is supposed
to be bug-free yet, but it does mean that we should be moving into
bugfixing mode in quick order.

And no, this is not an April 1 thing. But this way I can use April 1 as an
excuse if something doesn't actually compile. 

		Linus

----
*/

/*
 * Minimalistic "pwd" binary. Build using:
 *
 *	gcc -c pwd.S 
 *	ld pwd.o -o pwd.tmp
 *	objcopy --strip-all -R .data -R .bss pwd.tmp pwd
 */

/* ..text */
	.align 4
/* ..globl _start */
	.type	 _start,@function
_start:
	# allocate buffer
	subl $4096,%esp

	# do sys_getcwd system call
	movl $183,%eax		# sys_getcwd
	movl %esp,%ebx		# buffer
	movl $4096,%ecx		# size
	int $0x80

	# terminate with newline (%eax contains length + ending '\0')
	movb $10,-1(%esp,%eax)

	# do write system call
	movl %eax,%edx		# len
	movl $4,%eax		# sys_write
	movl $1,%ebx		# stdout
	movl %esp,%ecx		# buffer
	int $0x80

	# exit(0)
	movl $1,%eax		# sys_exit
	xorl %ebx,%ebx		# zero
	int $0x80
_start_end:
	.size	 _start,_start_end-_start

/*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu


*/