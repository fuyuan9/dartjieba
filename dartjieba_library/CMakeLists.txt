PROJECT(dartjieba_library)

CMAKE_MINIMUM_REQUIRED(VERSION 3.7 FATAL_ERROR)

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/deps
  ${PROJECT_SOURCE_DIR}/lib)

ADD_DEFINITIONS(-O3 -Wall -g)
IF(APPLE) # mac os
  ADD_DEFINITIONS(-std=c++0x)
endif()

ADD_SUBDIRECTORY(deps)

add_library(dartjieba_library SHARED lib/dartjieba.cpp)

set_target_properties(
  dartjieba_library
  PROPERTIES
    PUBLIC_HEADER lib/dartjieba.hpp
    OUTPUT_NAME "dartjieba"
)
