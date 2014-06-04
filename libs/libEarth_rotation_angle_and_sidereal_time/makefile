CC = gcc
CFLAGF = -c -pedantic -Wall -W -O
SOFA_LIB_NAME = libEarthRAST.so
SOFA_OBS = ee0a.o \
           pr00.o \
           obl80.o \
           nut00a.o \
           ee00.o \
           fal03.o \
           faf03.o \
		   

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