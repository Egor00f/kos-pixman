LIBRARY = pixman-1

CC = kos32-gcc
AR = kos32-ar
LD = kos32-ld
STRIP = kos32-strip

ifeq ($(OS),Windows_NT)
	TOOLCHAIN_PATH=C:/MinGW/msys/1.0/home/autobuild/tools/win32
else
	TOOLCHAIN_PATH=/home/autobuild/tools/win32
endif
INSTALLDIR:= $(TOOLCHAIN_PATH)/lib

CFLAGS = -U_Win32 -U_WIN32 -U__MINGW32__ -c -O2 -Wall -Winline -fno-ident -fomit-frame-pointer

LDFLAGS = -shared -s -T dll.lds --entry _DllStartup --image-base=0
LDFLAGS+= --out-implib lib$(LIBRARY).dll.a

ARFLAGS = cvrs

INCLUDES= -I. -I$(TOOLCHAIN_PATH)/include

LIBS:=  -ldll -lgcc -lc.dll

#DEFINES = -DHAVE_CONFIG_H -DPIXMAN_NO_TLS
DEFINES = -DHAVE_CONFIG_H


SOURCES =				\
	pixman.c			\
	pixman-access.c			\
	pixman-access-accessors.c	\
	pixman-bits-image.c		\
	pixman-combine32.c		\
	pixman-combine-float.c		\
	pixman-conical-gradient.c	\
	pixman-edge.c			\
	pixman-edge-accessors.c		\
	pixman-fast-path.c		\
	pixman-filter.c			\
	pixman-general.c		\
	pixman-glyph.c			\
	pixman-gradient-walker.c	\
	pixman-image.c			\
	pixman-implementation.c		\
	pixman-linear-gradient.c	\
	pixman-matrix.c			\
	pixman-noop.c			\
	pixman-radial-gradient.c	\
	pixman-region16.c		\
	pixman-region32.c		\
	pixman-solid-fill.c		\
	pixman-timer.c			\
	pixman-trap.c			\
	pixman-utils.c			\
	pixman-x86.c			\
	pixman-mmx.c			\
	pixman-sse2.c			\
	$(NULL)
 
OBJECTS     = $(patsubst %.c, %.o, $(SOURCES))

ifeq ($(findstring ebox,$(MAKECMDGOALS)),ebox)
CFLAGS+=-march=pentium-mmx
endif

# targets 

all:lib$(LIBRARY).a $(LIBRARY).dll

ebox:$lib(LIBRARY).a $(LIBRARY).dll

lib$(LIBRARY).a: $(OBJECTS) Makefile
	$(AR) $(ARFLAGS) lib$(LIBRARY).a $(OBJECTS)

$(LIBRARY).dll: $(LIBRARY).def $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -o $@ $(LIBRARY).def $(OBJECTS) $(LIBS)


install: lib$(LIBRARY).a $(LIBRARY).dll
	mv -f lib$(LIBRARY).a $(INSTALLDIR)
	#sed -f ../newlib/cmd1.sed $(LIBRARY).def > mem
	#sed -f ../newlib/cmd2.sed mem >$(LIBRARY).inc
	mv -f $@ ../../bin
	mv -f lib$(LIBRARY).dll.a $(INSTALLDIR)

%.o : %.c Makefile
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -o $@ $<

pixman-mmx.o: pixman-mmx.c Makefile
	$(CC) $(CFLAGS) -mmmx $(DEFINES) $(INCLUDES) -o $@ $<

pixman-sse2.o: pixman-sse2.c Makefile
	$(CC) $(CFLAGS) -msse2 $(DEFINES) $(INCLUDES) -o $@ $<


clean: 
	-rm -f *.o 
 