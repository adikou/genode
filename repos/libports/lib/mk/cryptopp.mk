CRYTOPP_PORT_DIR := $(call select_from_ports,cryptopp)
CRYTOPP_DIR      := $(CRYTOPP_PORT_DIR)/src/lib/cryptopp

FILTER_OUT = test.cpp validat1.cpp validat2.cpp validat3.cpp bench.cpp bench2.cpp datatest.cpp
SRC_CC += $(filter-out $(FILTER_OUT),$(notdir $(wildcard $(CRYTOPP_PORT_DIR)/src/lib/cryptopp/*.cpp)))

vpath %.cpp $(CRYTOPP_PORT_DIR)/src/lib/cryptopp

INC_DIR += $(CRYTOPP_PORT_DIR)/src/lib/cryptopp

CC_CXX_OPT += -Wno-unused-function -Wno-unused-variable -Wno-unused-value

LIBS += libc stdcxx libm
SHARED_LIB = yes
