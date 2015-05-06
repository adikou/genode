BOOST_DIR = $(call select_from_ports,boost)/src/lib/boost/boost_1_58_0

# Boost.Date_Time
SRC_CC += $(notdir $(wildcard $(BOOST_DIR)/libs/date_time/src/gregorian/*.cpp))

FILTER_OUT = operations.cpp
# Boost.Filesystem
SRC_CC += $(filter-out $(FILTER_OUT), $(notdir, $(wildcard $(BOOST_DIR)/libs/filesystem/src/*.cpp)))

# Boost.Regex
SRC_CC += $(notdir $(wildcard $(BOOST_DIR)/libs/regex/src/*.cpp))

#Boost.IOStreams
#SRC_CC += $(filter-out $(FILTER_OUT), $(notdir, $(wildcard $(BOOST_DIR)/libs/iostreams/src/*.cpp)))
SRC_CC += $(notdir $(wildcard $(BOOST_DIR)/libs/iostreams/src/*.cpp))

FILTER_OUT = convert.cpp
# Boost.Program_Options
SRC_CC += $(filter-out $(FILTER_OUT), $(notdir, $(wildcard $(BOOST_DIR)/libs/program_options/src/*.cpp)))

# Boost.Random
SRC_CC += $(notdir $(wildcard $(BOOST_DIR)/libs/random/src/*.cpp))

# Boost.System
SRC_CC += $(notdir $(wildcard $(BOOST_DIR)/libs/system/src/*.cpp))

# Boost.Chrono
SRC_CC += $(notdir $(wildcard $(BOOST_DIR)/libs/chrono/src/*.cpp))


#Boost.Serialization
#SRC_CC += $(notdir $(addprefix $(BOOST_DIR)/libs/serialization/src/, basic_oserializer.cpp \
#			basic_pointer_iserializer.cpp basic_pointer_oserializer.cpp basic_serializer_map.cpp \
#			extended_type_info.cpp stl_port.cpp void_cast.cpp))

FILTER-OUT = shared_ptr_helper.cpp
SRC_CC += $(filter-out $(FILTER_OUT), $(notdir, $(wildcard $(BOOST_DIR)/libs/serialization/src/*.cpp)))

INC_DIR += $(BOOST_DIR)

vpath %.cpp $(BOOST_DIR)/libs/filesystem/src

vpath %.cpp $(BOOST_DIR)/libs/chrono/src

vpath %.cpp $(BOOST_DIR)/libs/regex/src

vpath %.cpp $(BOOST_DIR)/libs/date_time/src/gregorian

vpath %.cpp $(BOOST_DIR)/libs/iostreams/src

vpath %.cpp $(BOOST_DIR)/libs/program_options/src

vpath %.cpp $(BOOST_DIR)/libs/random/src

vpath %.cpp $(BOOST_DIR)/libs/system/src

vpath %.cpp $(BOOST_DIR)/libs/serialization/src

LIBS += libc stdcxx libm libbz2 zlib

SHARED_LIB = yes
