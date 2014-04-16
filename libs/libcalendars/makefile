CC = gcc
CFLAGF = -c -pedantic -Wall -W -O
SOFA_LIB_NAME = libcalendars.so
SOFA_OBS = cal2jd.o \
           epb.o \
           epb2jd.o \
           epj.o \
           epj2jd.o \
           jd2cal.o \
           jdcalf.o

# Build the library.
$(SOFA_LIB_NAME): $(SOFA_OBS)
	$(CC) -o $(SOFA_LIB_NAME) -shared $?
  
cal2jd.o : cal2jd.c sofa.h sofam.h
	$(CC) $(CFLAGF) -o $@ cal2jd.c
epb.o    : epb.c    sofa.h sofam.h
	$(CC) $(CFLAGF) -o $@ epb.c
epb2jd.o : epb2jd.c sofa.h sofam.h
	$(CC) $(CFLAGF) -o $@ epb2jd.c
epj.o    : epj.c    sofa.h sofam.h
	$(CC) $(CFLAGF) -o $@ epj.c
epj2jd.o : epj2jd.c sofa.h sofam.h
	$(CC) $(CFLAGF) -o $@ epj2jd.c
jd2cal.o : jd2cal.c sofa.h sofam.h
	$(CC) $(CFLAGF) -o $@ jd2cal.c
jdcalf.o : jdcalf.c sofa.h sofam.h
	$(CC) $(CFLAGF) -o $@ jdcalf.c