
CV_DIR  = ../OpenCV-2.4.2
OBJS    = obj/test_lbph.o
CFLAGS  = -O \
	-I$(CV_DIR)/include -I$(CV_DIR)/modules/contrib/include \
	-I$(CV_DIR)/modules/core/include
LDFLAGS = -L$(CV_DIR)/build/lib -lopencv_core -lopencv_contrib -lopencv_highgui
GXX     = g++

# Linux
TARGET  = bin/test_lbph

all: $(TARGET)

obj/%.o: src/%.cpp
	@mkdir -p obj
	$(GXX) -c $< -o $@ $(CFLAGS)

$(TARGET): $(OBJS)
	@mkdir -p bin
	$(GXX) $(OBJS) -o $@ $(LDFLAGS)

clean:
	rm -rf obj bin

test: $(TARGET) att_faces.csv
	LD_LIBRARY_PATH=$(CV_DIR)/build/lib $(TARGET) att_faces.csv

att_faces.csv:
	python create_csv.py ../database/att_faces > att_faces.csv
