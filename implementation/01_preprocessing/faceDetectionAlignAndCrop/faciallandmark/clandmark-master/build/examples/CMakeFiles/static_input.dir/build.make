# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.2

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build

# Include any dependencies generated for this target.
include examples/CMakeFiles/static_input.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/static_input.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/static_input.dir/flags.make

examples/CMakeFiles/static_input.dir/static_input.cpp.o: examples/CMakeFiles/static_input.dir/flags.make
examples/CMakeFiles/static_input.dir/static_input.cpp.o: ../examples/static_input.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object examples/CMakeFiles/static_input.dir/static_input.cpp.o"
	cd /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/examples && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/static_input.dir/static_input.cpp.o -c /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/examples/static_input.cpp

examples/CMakeFiles/static_input.dir/static_input.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/static_input.dir/static_input.cpp.i"
	cd /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/examples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/examples/static_input.cpp > CMakeFiles/static_input.dir/static_input.cpp.i

examples/CMakeFiles/static_input.dir/static_input.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/static_input.dir/static_input.cpp.s"
	cd /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/examples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/examples/static_input.cpp -o CMakeFiles/static_input.dir/static_input.cpp.s

examples/CMakeFiles/static_input.dir/static_input.cpp.o.requires:
.PHONY : examples/CMakeFiles/static_input.dir/static_input.cpp.o.requires

examples/CMakeFiles/static_input.dir/static_input.cpp.o.provides: examples/CMakeFiles/static_input.dir/static_input.cpp.o.requires
	$(MAKE) -f examples/CMakeFiles/static_input.dir/build.make examples/CMakeFiles/static_input.dir/static_input.cpp.o.provides.build
.PHONY : examples/CMakeFiles/static_input.dir/static_input.cpp.o.provides

examples/CMakeFiles/static_input.dir/static_input.cpp.o.provides.build: examples/CMakeFiles/static_input.dir/static_input.cpp.o

# Object files for target static_input
static_input_OBJECTS = \
"CMakeFiles/static_input.dir/static_input.cpp.o"

# External object files for target static_input
static_input_EXTERNAL_OBJECTS =

examples/static_input: examples/CMakeFiles/static_input.dir/static_input.cpp.o
examples/static_input: examples/CMakeFiles/static_input.dir/build.make
examples/static_input: libclandmark/libflandmark.so.1.5
examples/static_input: /usr/lib/libopencv_objdetect.so.2.4.13
examples/static_input: /usr/lib/libopencv_highgui.so.2.4.13
examples/static_input: libclandmark/libclandmark.so.1.5
examples/static_input: /usr/lib/libopencv_imgproc.so.2.4.13
examples/static_input: /usr/lib/libopencv_core.so.2.4.13
examples/static_input: examples/CMakeFiles/static_input.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable static_input"
	cd /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/static_input.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/static_input.dir/build: examples/static_input
.PHONY : examples/CMakeFiles/static_input.dir/build

examples/CMakeFiles/static_input.dir/requires: examples/CMakeFiles/static_input.dir/static_input.cpp.o.requires
.PHONY : examples/CMakeFiles/static_input.dir/requires

examples/CMakeFiles/static_input.dir/clean:
	cd /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/static_input.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/static_input.dir/clean

examples/CMakeFiles/static_input.dir/depend:
	cd /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/examples /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/examples /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/examples/CMakeFiles/static_input.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/static_input.dir/depend

