@author: Aditya Kousik
@email : adit267.kousik@gmail.com

---------------------------------------------------------------------
Some thoughts on the attempt of porting the ndn-cxx library to Genode
---------------------------------------------------------------------

Named Data Networking is a novel Internet architecture that encourages
data driven networking, as opposed to the user-centric architecture of
today's Internet.

It treats the request for a data object as an Interest for it and each
object is uniquely named with a Name, and an associated Data for it.
As a curiosity, I've attempted at bringing the ndn-cxx library on a 
microkernel platform like Genode while it is heavily based on Linux.

This initial port is untested, but it builds fine subject to a number 
of tweaks and configurations. The first milestone was to build all
ndn-cxx source files and link all references appropriately. It is 
heavily dependent on the boost libraries, libsqlite3 and libcrypto++.

While there was a primary port of libsqlite, the heavy boost libraries
and libcrypto++ were not ported. In the process, I've written basic
port files for these libraries as well.

The compilation of each of boost, cryptopp (Crypto++), and ndn-cxx is
subject to replacing the files available in GENODE_DIR/repos/libports/
src/test/ndn-cxx-hacks folder in the appropriate fetched code by exec-
uting the prepare_port file in tool/ports/prepare_port.

--------------------------
Steps for building ndn-cxx
--------------------------

ndn-cxx depends on boost, sqlite, cryptopp, libc, stdcxx, and lxip
plugin of libc. These libraries are in turn dependent on libm, libbz2,
and zlib.

Therefore, prepare ports of libc, dde_linux, stdcxx, zlib, and bzip2.
Next, prepare sqlite, boost, cryptopp, and ndn-cxx.

Replace the following files in the specified location.
The hierarchy assumes contrib/library-<hash> as the port directory.

*****
Boost
*****

Src:  ndn-cxx-hacks/boost/boost/asio/detail/config.hpp
Dest1: contrib/boost-<hash>/include/boost/asio/detail/config.hpp and,
Dest2: contrib/boost-<hash>/src/lib/boost/boost_1_58_0/boost/asio/detail \
													/config.hpp

Src:  ndn-cxx-hacks/boost/libs/filesystem/src/operations.cpp
Dest: contrib/boost-<hash>/src/lib/boost/boost_1_58_0/libs/filesystem \
													/src/operations.cpp

********
cryptopp
********

Src:  ndn-cxx-hacks/cryptopp/config.h
Dest1: contrib/cryptopp-<hash>/include/cryptopp/config.h
Dest2: contrib/cryptopp-<hash>/src/lib/cryptopp/config.h

****
libc
****

Src:  ndn-cxx-hacks/libc/lib/libc/net/sendmsg.c
Dest: contrib/libc-<hash>/src/lib/libc/lib/libc/net/

*******
ndn-cxx
*******

Src:  ndn-cxx-hacks/ndn-cxx/src/ndn-cxx-config.hpp
Dest: contrib/ndn-cxx-<hash>/src/lib/ndn-cxx/src/ndn-cxx-config.hpp

------------------------
Building ndn-cxx library
------------------------

Create a build directory
$> ./tool/create_builddir <platform> BUILD_DIR=<build-dir>

Make the dummy application that uses the ndn-cxx library

$> cd <build-dir>
$> make -j4 test/libports/ndn-cxx
