NDN-CXX_DIR = $(call select_from_ports,ndn-cxx)/src/lib/ndn-cxx

# NDN-CXX main src directory
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/*.cpp))

# NDN-CXX security
FILTER_OUT = sec-tpm-file.cpp sec-tpm-osx.cpp
SRC_CC += $(filter-out $(FILTER_OUT), $(notdir $(wildcard $(NDN-CXX_DIR)/src/security/*.cpp)))

# NDN-CXX security/conf
SRC_CC += $(notdir, $(wildcard $(NDN-CXX_DIR)/src/security/conf/*.cpp))

# NDN-CXX encoding
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/encoding/*.cpp))

# NDN-CXX encoding/cryptopp
SRC_CC += $(notdir $(NDN-CXX_DIR)/src/encoding/cryptopp/asn_ext.cpp)

# NDN-CXX management
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/management/*.cpp))


# NDN-CXX transport
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/transport/*.cpp))

# NDN-CXX util
FILTER_OUT = network-monitor.cpp
SRC_CC += $(filter-out $(FILTER_OUT), $(notdir, $(wildcard $(NDN-CXX_DIR)/src/util/*.cpp)))
#SRC_CC += $(notdir, $(addprefix $(NDN-CXX_DIR)/src/util/, config-file.cpp \
#			crypto.cpp digest.cpp dns.cpp dummy-client-face.cpp ethernet.cpp \
#			face-uri.cpp indented-stream.cpp in-memory-storage.cpp in-memory-storage-entry.cpp \
#			in-memory-storage-fifo.cpp in-memory-storage-lfu.cpp in-memory-storage-lru.cpp \
#			in-memory-storage-persistent.cpp random.cpp scheduler.cpp \
#			scheduler-scoped-event-id.cpp segment-fetcher.cpp signal-connection.cpp \
#			signal-scoped-connection.cpp time.cpp time-unit-test-clock.cpp))

# NDN-CXX util/regex
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/util/regex/*.cpp))

INC_DIR += $(NDN-CXX_DIR)/src

vpath %.cpp $(NDN-CXX_DIR)/src

vpath %.cpp $(NDN-CXX_DIR)/src/encoding

vpath %.cpp $(NDN-CXX_DIR)/src/encoding/cryptopp

vpath %.cpp $(NDN-CXX_DIR)/src/management

vpath %.cpp $(NDN-CXX_DIR)/src/security

vpath %.cpp $(NDN-CXX_DIR)/src/security/conf

vpath %.cpp $(NDN-CXX_DIR)/src/transport

vpath %.cpp $(NDN-CXX_DIR)/src/util

vpath %.cpp $(NDN-CXX_DIR)/src/util/regex

LIBS += libc stdcxx sqlite cryptopp boost libc_lxip

SHARED_LIB = yes
