#----------------------------------------------------------------
# Generated CMake target import file for configuration "RELEASE".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "CLandmark::clandmark" for configuration "RELEASE"
set_property(TARGET CLandmark::clandmark APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(CLandmark::clandmark PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libclandmark.so.1.5"
  IMPORTED_SONAME_RELEASE "libclandmark.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS CLandmark::clandmark )
list(APPEND _IMPORT_CHECK_FILES_FOR_CLandmark::clandmark "${_IMPORT_PREFIX}/lib/libclandmark.so.1.5" )

# Import target "CLandmark::flandmark" for configuration "RELEASE"
set_property(TARGET CLandmark::flandmark APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(CLandmark::flandmark PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libflandmark.so.1.5"
  IMPORTED_SONAME_RELEASE "libflandmark.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS CLandmark::flandmark )
list(APPEND _IMPORT_CHECK_FILES_FOR_CLandmark::flandmark "${_IMPORT_PREFIX}/lib/libflandmark.so.1.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
