# CYCLONEPHYSICS LIB
CXXFLAGS=-O2 -I./include -fPIC
CYCLONEOBJS=src/body.o src/collide_coarse.o src/collide_fine.o src/contacts.o src/core.o src/fgen.o src/joints.o src/particle.o src/pcontacts.o src/pfgen.o src/plinks.o src/pworld.o src/random.o src/world.o

# DEMO FILES
SOURCES=body
LDFLAGS=-std=c++0x
DEMO_CPP=./src/demos/app.cpp ./src/demos/timing.cpp ./src/demos/main.cpp

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
LDFLAGS+=-lGL -lglut -lGLU
LIBSUFFIX=so
LIBFLAGS=-shared -dynamiclib
endif
ifeq ($(UNAME), Darwin)
LDFLAGS=-framework GLUT -framework OpenGL -framework Cocoa
LIBSUFFIX=dylib
LIBFLAGS=-dynamiclib 
#-install_name libcyclone.dylib
endif

CYCLONELIB=libcyclone.$(LIBSUFFIX)
DEMOS=ballistic bigballistic blob bridge explosion fireworks flightsim fracture platform ragdoll sailboat

all:	$(CYCLONELIB) $(DEMOS)

$(CYCLONELIB): $(CYCLONEOBJS)
	$(CXX) $(CYCLONEOBJS) $(LIBFLAGS) -o lib/$(CYCLONELIB)

$(DEMOS): 
	$(CXX) -o ./bin/$@ $(DEMO_CPP) ./lib/$(CYCLONELIB) ./src/demos/$@/$@.cpp $(CXXFLAGS) $(LDFLAGS) 


clean:
	rm -f src/*.o lib/$(CYCLONELIB)
	rm -f 		\
	./bin/fireworks		\
	./bin/fracture		\
	./bin/flightsim		\
	./bin/bridge		\
	./bin/sailboat		\
	./bin/explosion		\
	./bin/ballistic		\
	./bin/platform		\
	./bin/bigballistic	\
	./bin/blob		\
	./bin/ragdoll
