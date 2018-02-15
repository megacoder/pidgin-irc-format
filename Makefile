CC	=gcc -march=native -std=gnu99
CFLAGS	=-O3 -fPIC -Wall -pedantic -pipe
CFLAGS	+= `pkg-config --cflags pidgin`

LDFLAGS	=-shared

LDLIBS	=`pkg-config --libs pidgin`

PREFIX := /usr
LIBDIR := ${PREFIX}/lib64

SOURCES := ${wildcard *.c}
OBJECTS := ${patsubst %.c, %.o, ${SOURCES}}

all:: pidgin-irc-format.so

pidgin-irc-format.so:: ${OBJECTS}
	${CC} -o $@ ${CFLAGS} ${LDFLAGS} ${LDLIBS} $^

install:: pidgin-irc-format.so
	install -D $^ ${DESTDIR}${LIBDIR}/pidgin/$^

clean::
	${RM} *.o a.out core*

clobber distclean:: clean
	${RM} pidgin-irc-format.so
