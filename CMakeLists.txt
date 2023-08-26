############################
### C++ Project Template ###
############################

# Version guard
# 3.5 required for the environment variable CMAKE_EXPORT_COMPILE_COMMANDS
# 3.17 for CPACK_NSIS_MUI_HEADERIMAGE
# 3.18 for CPACK_NSIS_MANIFEST_DPI_AWARE
# 3.21 for cmake-presets version 3
cmake_minimum_required (VERSION 3.21)

# Do not allow in-source builds.
if(CMAKE_CURRENT_BINARY_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
	message(FATAL_ERROR "Building in-source is not supported!\nCreate a \"build\" dir and remove:\n- ${CMAKE_SOURCE_DIR}/CMakeCache.txt\n- ${CMAKE_SOURCE_DIR}/CMakeFiles")
endif()

# Print CMake variables: https://stackoverflow.com/a/69084164/3049315
#include(CMakePrintHelpers)
#cmake_print_variables(CMAKE_CURRENT_BINARY_DIR CMAKE_CURRENT_SOURCE_DIR)

###############
### OPTIONS ###
###############

# Useful if we only wish to build documentation in a machine or
# Docker container without compilers available.
# See: https://cmake.cmake.narkive.com/OMnbmBIb/without-c-c-compiler-check
option(BUILD_SOURCE "Build primary libraries and executables." ON)
# The BUILD_TESTING option is automatically created by CTest

#############################
### PROJECT CONFIGURATION ###
#############################

set(PROJECT_LANGUAGES NONE)
if(${BUILD_SOURCE})
	set(PROJECT_LANGUAGES CXX)
endif()

project (cpp-project-template
	VERSION 0.0.1.0
	DESCRIPTION "C++ Project Template"
	HOMEPAGE_URL "https://github.com/MangaD/cpp-project-template"
	LANGUAGES ${PROJECT_LANGUAGES})

# Global variables
set(AUTHOR_NAME "MangaD")
set(ORGANIZATION "MangaD")
set(CPACK_PACKAGE_VENDOR "${ORGANIZATION}")
set(CPACK_PACKAGE_CONTACT "${AUTHOR_NAME}")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(PROJECT_LANGUAGE_NEUTRAL 0) # if 0, language will be set to English in version.rc, otherwise neutral
string(TIMESTAMP COPYRIGHT_YEAR "%Y")
set(CPACK_PACKAGE_COPYRIGHT "© ${COPYRIGHT_YEAR} ${CPACK_PACKAGE_VENDOR}")
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(ASSETS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/assets)
set(PACKAGING_DIR ${CMAKE_CURRENT_SOURCE_DIR}/packaging)
set(DOCS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/docs)
set(DOXYGEN_DIR ${DOCS_DIR}/doxygen)
set(SPHINX_DIR ${DOCS_DIR}/sphinx)

# use your own default generated GUID (must comment this line)
set(CPACK_WIX_UPGRADE_GUID "02FBAAA4-B5EE-435B-AF4A-ADA99C5EAFA0")

# Read LICENSE file into a variable to be used by config.h
file(READ ${CPACK_RESOURCE_FILE_LICENSE} LICENSE NEWLINE_CONSUME ENCODING "UTF-8")
string(REGEX REPLACE "\n\n" ")#license#\"\"\\\\n\\\\n\" R\"#license#(" LICENSE "${LICENSE}") # keep double newlines
string(REGEX REPLACE "\n" " " LICENSE "${LICENSE}") # remove single newlines
string(REGEX REPLACE "  +" " " LICENSE "${LICENSE}") # remove excess spaces
#string(REPLACE "\"" "\\\"" LICENSE "${LICENSE}") # Escape quotes for using as C-style string

# CMake variables in source code
configure_file("${SOURCE_DIR}/config.h.in" config.h)

# Why cache: https://cliutils.gitlab.io/modern-cmake/chapters/features/cpp11.html
set(CMAKE_CXX_STANDARD 20 CACHE STRING "The C++ standard to use")
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# By default we place binaries in this directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

# Generate a `compile_commands.json` file for use with clang-based tools
# https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# We add a flag to llvm-rc because of the following issue:
# https://github.com/llvm/llvm-project/issues/57367
if(WIN32 AND "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	set(CMAKE_RC_FLAGS "${CMAKE_RC_FLAGS} /C 65001")
endif()

#####################
### CMake modules ###
#####################

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(cmake/doxygen.cmake)
include(cmake/sphinx.cmake)
include(cmake/clang-format.cmake)

if (CMAKE_BUILD_TYPE STREQUAL "Coverage")
	include(CodeCoverage)
endif()

###############
### TARGETS ###
###############

if(${BUILD_SOURCE})
	set(PROJECT_LIB_NAME projectlib)
	set(PROJECT_LIB_DIR ${SOURCE_DIR}/${PROJECT_LIB_NAME})
	add_subdirectory(${PROJECT_LIB_DIR}/src)

	set(PROJECT_CLI_NAME projectcli)
	set(PROJECT_CLI_DIR ${SOURCE_DIR}/${PROJECT_CLI_NAME})
	add_subdirectory(${PROJECT_CLI_DIR})

	set(PROJECT_WX_NAME projectwx)
	option(BUILD_PROJECTWX "Build ${PROJECT_WX_NAME}" ON)
	set(PROJECT_WX_DIR ${SOURCE_DIR}/${PROJECT_WX_NAME})
	if(BUILD_PROJECTWX)
		add_subdirectory(${PROJECT_WX_DIR}/src)
	endif()
endif()

#############
### CTEST ###
#############

enable_testing()
include (CTest)

if(BUILD_SOURCE AND BUILD_TESTING)
	add_test(NAME Runs
		COMMAND $<TARGET_FILE:${PROJECT_CLI_NAME}>)
	add_test(NAME Runs-v
		COMMAND $<TARGET_FILE:${PROJECT_CLI_NAME}> -v)
	add_test(NAME Runs-h
		COMMAND $<TARGET_FILE:${PROJECT_CLI_NAME}> -h)
	add_test(NAME Runs-invalid
		COMMAND $<TARGET_FILE:${PROJECT_CLI_NAME}> --invalid)
		set_tests_properties(Runs-invalid PROPERTIES WILL_FAIL TRUE)

	# CTest with valgring: https://stackoverflow.com/a/40437731/3049315
	include(cmake/memcheck.cmake)

	# Test projectlib
	add_subdirectory(${PROJECT_LIB_DIR}/test)
endif()

#############
### CPACK ###
#############

if(${BUILD_SOURCE})
	# See: https://cmake.org/cmake/help/latest/guide/tutorial/Installing%20and%20Testing.html
	install(TARGETS ${PROJECT_CLI_NAME} DESTINATION bin)
	if(BUILD_PROJECTWX)
		install(TARGETS ${PROJECT_WX_NAME} DESTINATION bin)
	endif()
	install(DIRECTORY "${ASSETS_DIR}/images" DESTINATION ".")

	include(cmake/cpack_module.cmake)
endif()
