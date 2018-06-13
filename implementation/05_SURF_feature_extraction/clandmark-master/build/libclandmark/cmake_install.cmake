# Install script for directory: /home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RELEASE")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclandmark.so.1.5"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclandmark.so.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclandmark.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/libclandmark/libclandmark.so.1.5"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/libclandmark/libclandmark.so.1"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/libclandmark/libclandmark.so"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclandmark.so.1.5"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclandmark.so.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclandmark.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libflandmark.so.1.5"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libflandmark.so.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libflandmark.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/libclandmark/libflandmark.so.1.5"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/libclandmark/libflandmark.so.1"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/libclandmark/libflandmark.so"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libflandmark.so.1.5"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libflandmark.so.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libflandmark.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_REMOVE
           FILE "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Devel")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/msvc-compat.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/base64.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CLandmark.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CFeaturePool.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CFeatures.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CAppearanceModel.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CDeformationCost.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CLoss.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CMaxSumSolver.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CXMLInOut.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CTimer.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CTypes.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/build/CLandmarkConfig.h"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Devel")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/Flandmark.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CSparseLBPFeatures.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CSparseLBPAppearanceModel.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CDisplacementDeformationCost.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CNormalizedEuclideanLoss.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CTableLoss.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CZeroLoss.h"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/libclandmark/CTreeMaxSumSolver.h"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/clandmark/models" TYPE FILE FILES
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/data/flandmark_model.xml"
    "/home/antonio/Desktop/COSFIRE/COSFIRE/COSFIRE_MatlabCode/clandmark-master/data/haarcascade_frontalface_alt.xml"
    )
endif()

