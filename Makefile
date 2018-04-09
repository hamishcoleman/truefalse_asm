CFLAGS=-m32 -Wall

%:	%.S
%:	%.s
%.o:	%.S

%.s:	%.S
	$(CPP) -o $*.s $<
%.o:	%.s
	$(AS) --32 -o $*.o $<
%:	%.o
	$(LD) -m i386linux -o $* $<
	chmod a+x $*

all:	true false bdflush pwd swapon

strip:	true false bdflush pwd swapon
	strip true false bdflush pwd swapon

clean:
	rm -f true.o false.o bdflush.o true.s false.s bdflush.s *~

clobber:	clean
	rm -f true false bdflush pwd swapon

dep:

install:	true false
	install -s -g bin -o bin -m a=rx true /bin
	install -s -g bin -o bin -m a=rx false /bin
	install -s -g bin -o bin -m a=rx bdflush /sbin
	install -s -g bin -o bin -m a=rx pwd /bin
