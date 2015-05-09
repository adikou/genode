NDN-CXX_DIR = $(call select_from_ports,ndn-cxx)/src/lib/ndn-cxx

# NDN-CXX main src directory
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/*.cpp))

# NDN-CXX encoding
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/encoding/*.cpp))

# NDN-CXX encoding/cryptopp
SRC_CC += $(notdir $(NDN-CXX_DIR)/src/encoding/cryptopp/asn_ext.cpp)

# NDN-CXX management
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/management/*.cpp))

# NDN-CXX security
# Filter out is playing games. Manually adding files for now
SRC_CC += 	public-key.cpp certificate.cpp \
			signature-sha256-with-rsa.cpp sec-tpm-file.cpp validator-config.cpp sec-public-info.cpp \
			key-params.cpp certificate-extension.cpp signature-sha256-with-ecdsa.cpp digest-sha256.cpp \
			sec-rule-specific.cpp sec-rule-relative.cpp sec-public-info-sqlite3.cpp validator.cpp \
			sec-tpm.cpp secured-bag.cpp certificate-cache-ttl.cpp certificate-subject-description.cpp \
			key-chain.cpp identity-certificate.cpp validator-regex.cpp


# NDN-CXX security/conf
SRC_CC += $(notdir, $(wildcard $(NDN-CXX_DIR)/src/security/conf/*.cpp))

# NDN-CXX transport
SRC_CC += $(notdir $(wildcard $(NDN-CXX_DIR)/src/transport/*.cpp))

# NDN-CXX util
FILTER_OUT = network-monitor.cpp time-unit-test-clock.cpp
SRC_CC += $(filter-out $(FILTER_OUT),$(notdir $(wildcard $(NDN-CXX_DIR)/src/util/*.cpp)))

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
