CFLAGS= -Wall

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

all:	true false bdflush pwd #swapon

strip:	true false bdflush
	strip true false bdflush

clean:
	rm -f true.o false.o bdflush.o true.s false.s bdflush.s *~

clobber:	clean
	rm -f true false bdflush

dep:

install:	true false
	install -s -g bin -o bin -m a=rx true /bin
	install -s -g bin -o bin -m a=rx false /bin
	install -s -g bin -o bin -m a=rx bdflush /sbin
	install -s -g bin -o bin -m a=rx pwd /bin
