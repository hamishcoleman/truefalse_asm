CFLAGS= -Wall

#.S.s:
#	$(CPP) -traditional $< -o $*.s
#.c.s:
#	$(CC) $(CFLAGS) -S $<
#.s.o:
#	$(AS) -c -o $*.o $<
#.c.o:
#	$(CC) $(CFLAGS) -c $<

AS=/usr/ix86-linuxaout/bin/as

%:	%.S
%:	%.s
%.o:	%.S

%.s:	%.S
	$(CPP) -o $*.s $<
%.o:	%.s
	$(AS) -o $*.o $<
%:	%.o
	$(LD) -m i386linux -r -o $* $<
	chmod a+x $*

all:	true false

true:	true.S
	$(CC) $(CFLAGS) -nostdlib -N -o $@ $<

false:	false.S
	$(CC) $(CFLAGS) -nostdlib -N -o $@ $<

bdflush:	bdflush.S
	$(CC) $(CFLAGS) -nostdlib -N -o $@ $<

