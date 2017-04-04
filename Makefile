# Makefile for SVM-multiclass, 03.07.04

CC = gcc
LD = gcc
#CC = attolcc -mempro -perfpro -block -proc -- gcc
#LD = attolcc -mempro -perfpro -block -proc -- gcc
CFLAGS = -O3 -fomit-frame-pointer -ffast-math -Wall 
LDFLAGS = -O3 -lm -Wall
#CFLAGS = -g -Wall
#LDFLAGS = -g -lm
#CFLAGS = -pg -Wall
#LDFLAGS = -pg -lm -Wall 

all: svm_multiclass_learn_hideo svm_multiclass_classify CImg.h a3.cpp Classifier.h NearestNeighbor.h
	g++ a3.cpp -o a3 -lX11 -lpthread -I. -Isiftpp -O3 siftpp/sift.cpp

.PHONY: clean
clean: svm_light_clean svm_struct_clean
	rm -f *.o *.tcov *.d core gmon.out *.stackdump a3

#-----------------------#
#----   SVM-light   ----#
#-----------------------#
svm_light_hideo_noexe: 
	cd svm_light; make svm_learn_hideo_noexe

svm_light_loqo_noexe: 
	cd svm_light; make svm_learn_loqo_noexe

svm_light_clean: 
	cd svm_light; make clean

#----------------------#
#----  STRUCT SVM  ----#
#----------------------#

svm_struct_noexe: 
	cd svm_struct; make svm_struct_noexe

svm_struct_clean: 
	cd svm_struct; make clean

#-------------------------#
#----  SVM MULTICLASS ----#
#-------------------------#

svm_multiclass_classify: svm_light_hideo_noexe svm_struct_noexe svm_struct_api.o svm_struct/svm_struct_classify.o svm_struct/svm_struct_common.o svm_struct/svm_struct_main.o 
	$(LD) $(LDFLAGS) svm_struct_api.o svm_struct/svm_struct_classify.o svm_light/svm_common.o svm_struct/svm_struct_common.o -o svm_multiclass_classify $(LIBS)

svm_multiclass_learn_loqo: svm_light_loqo_noexe svm_struct_noexe svm_struct_api.o svm_struct/svm_struct_learn.o svm_struct/svm_struct_common.o svm_struct/svm_struct_main.o 
	$(LD) $(LDFLAGS) svm_struct/svm_struct_learn.o svm_struct_api.o svm_light/svm_loqo.o svm_light/pr_loqo/pr_loqo.o svm_light/svm_learn.o svm_light/svm_common.o svm_struct/svm_struct_common.o svm_struct/svm_struct_main.o -o svm_multiclass_learn $(LIBS)

svm_multiclass_learn_hideo: svm_light_hideo_noexe svm_struct_noexe svm_struct_api.o  svm_struct/svm_struct_learn.o svm_struct/svm_struct_common.o svm_struct/svm_struct_main.o
	$(LD) $(LDFLAGS) svm_struct/svm_struct_learn.o svm_struct_api.o svm_light/svm_hideo.o svm_light/svm_learn.o svm_light/svm_common.o svm_struct/svm_struct_common.o svm_struct/svm_struct_main.o -o svm_multiclass_learn $(LIBS)


svm_struct_api.o: svm_struct_api.c svm_struct_api.h svm_struct_api_types.h svm_struct/svm_struct_common.h
	$(CC) -c $(CFLAGS) svm_struct_api.c -o svm_struct_api.o

