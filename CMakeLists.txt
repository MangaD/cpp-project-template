############################
### C++ Project Template ###
############################

# Version guard
# 3.5 required for the environment variable CMAKE_EXPORT_COMPILE_COMMANDS
# 3.17 for CPACK_NSIS_MUI_HEADERIMAGE
# 3.18 for CPACK_NSIS_MANIFEST_DPI_AWARE
cmake_minimum_required (VERSION 3.18)

# Do not allow in-source builds.
if(${CMAKE_CURRENT_BINARY_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
	message(FATAL_ERROR "Building in-source is not supported!\nCreate a \"build\" dir and remove:\n- ${CMAKE_SOURCE_DIR}/CMakeCache.txt\n- ${CMAKE_SOURCE_DIR}/CMakeFiles")
endif()

#############################
### PROJECT CONFIGURATION ###
#############################

project (cpp-project-template
	VERSION 1.0.0.0
	DESCRIPTION "C++ Project Template"
	HOMEPAGE_URL "https://github.com/MangaD/cpp-project-template"
	LANGUAGES CXX)

# Global variables
set(AUTHOR_NAME "MangaD")
set(ORGANIZATION "MangaD")
set(CPACK_PACKAGE_VENDOR "${ORGANIZATION}")
set(CPACK_PACKAGE_CONTACT "${AUTHOR_NAME}")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(PROJECT_LANGUAGE_NEUTRAL 0) # if 0, language will be set to English in version.rc, otherwise neutral
string(TIMESTAMP COPYRIGHT_YEAR "%Y")
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(ASSETS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/assets)
set(DOXYGEN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen)
set(SPHINX_DIR ${CMAKE_CURRENT_SOURCE_DIR}/docs/sphinx)

# Read LICENSE file into a variable
file(STRINGS LICENSE LICENSE NEWLINE_CONSUME ENCODING "UTF-8")
string(REGEX REPLACE "\n\n" "\\\\n\\\\n" LICENSE "${LICENSE}") # keep double newlines
string(REGEX REPLACE "\n" " " LICENSE "${LICENSE}") # remove single newlines
string(REPLACE "\"" "\\\"" LICENSE "${LICENSE}") # Escape quotes for using as C-style string

# Print CMake variables: https://stackoverflow.com/a/69084164/3049315
#include(CMakePrintHelpers)
#cmake_print_variables(PROJECT_SOURCE_DIR CMAKE_CURRENT_BINARY_DIR CMAKE_CURRENT_SOURCE_DIR)

# CMake variables in source code
configure_file("${SOURCE_DIR}/config.h.in" config.h)

# Version information on windows
if (WIN32)
	configure_file("${ASSETS_DIR}/version.rc.in" version.rc)
endif()

# Why cache: https://cliutils.gitlab.io/modern-cmake/chapters/features/cpp11.html
set(CMAKE_CXX_STANDARD 20 CACHE STRING "The C++ standard to use")
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# By default we put binaries into this directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

# Generate a `compile_commands.json` file for use with clang-based tools
# https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

###############
### TARGETS ###
###############

set(PROJECT_LIB_NAME projectlib)
set(PROJECT_LIB_DIR ${SOURCE_DIR}/${PROJECT_LIB_NAME})
add_library(${PROJECT_LIB_NAME} STATIC "")
add_subdirectory(${PROJECT_LIB_DIR})

set(PROJECT_CLI_NAME projectcli)
set(PROJECT_CLI_DIR ${SOURCE_DIR}/${PROJECT_CLI_NAME})
add_executable(${PROJECT_CLI_NAME} "")
add_subdirectory(${PROJECT_CLI_DIR})

find_package(wxWidgets REQUIRED
    COMPONENTS
    core
    base
    adv)

# Bring the headers into the project
include(${wxWidgets_USE_FILE})

set(PROJECT_WX_NAME projectwx)
set(PROJECT_WX_DIR ${SOURCE_DIR}/${PROJECT_WX_NAME})
add_executable(${PROJECT_WX_NAME} WIN32 "")
add_subdirectory(${PROJECT_WX_DIR})

#####################
### CMake modules ###
#####################

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(cmake/doxygen.cmake)
include(cmake/sphinx.cmake)
# cppcheck uses the PROJECT_LIB_DIR variable
include(cmake/cppcheck.cmake)
# clang-tidy uses the PROJECT_LIB_DIR variable
include(cmake/clang-tidy.cmake)
include(cmake/clang-format.cmake)
# Sanitizers must come after add_executable or add_library, and target name
# must be changed in the module accordingly.
include(cmake/sanitizer.cmake)

#############
### CTEST ###
#############

# See:
# - https://cmake.org/cmake/help/latest/guide/tutorial/Installing%20and%20Testing.html
# - https://coderefinery.github.io/cmake-workshop/testing/
# - https://stackoverflow.com/a/40437731/3049315

include (CTest)

enable_testing()

# does the application run
add_test(NAME Runs
	COMMAND $<TARGET_FILE:${PROJECT_CLI_NAME}>)

include(cmake/memcheck.cmake)

#############
### CPACK ###
#############

# See: https://cmake.org/cmake/help/latest/guide/tutorial/Installing%20and%20Testing.html
install(TARGETS ${PROJECT_CLI_NAME} DESTINATION bin)
install(TARGETS ${PROJECT_WX_NAME} DESTINATION bin)
install(DIRECTORY "${ASSETS_DIR}/images" DESTINATION ".")

include(cmake/cpack_module.cmake)
