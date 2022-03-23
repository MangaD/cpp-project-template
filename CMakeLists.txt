# Version guard
# 3.5 required for the environment variable CMAKE_EXPORT_COMPILE_COMMANDS
# 3.17 for CPACK_NSIS_MUI_HEADERIMAGE
# 3.18 for CPACK_NSIS_MANIFEST_DPI_AWARE
cmake_minimum_required (VERSION 3.18)

if(${CMAKE_CURRENT_BINARY_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
	message(FATAL_ERROR "Building in-source is not supported!\nCreate a \"build\" dir and remove:\n- ${CMAKE_SOURCE_DIR}/CMakeCache.txt\n- ${CMAKE_SOURCE_DIR}/CMakeFiles")
endif()

#############################
### PROJECT CONFIGURATION ###
#############################

project (DG
	VERSION 1.0.0.0
	DESCRIPTION "David Gonçalves code test for Tickingbot Oy"
	HOMEPAGE_URL "https://github.com/Tickingbot/DG"
	LANGUAGES CXX)

set(AUTHOR_NAME "David Gonçalves")
set(ORGANIZATION "Tickingbot")
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

# Print CMake variables: https://stackoverflow.com/a/69084164/3049315
#include(CMakePrintHelpers)
#cmake_print_variables(PROJECT_SOURCE_DIR CMAKE_CURRENT_BINARY_DIR CMAKE_CURRENT_SOURCE_DIR)

# CMake variables in source code
configure_file("${SOURCE_DIR}/DGConfig.h.in" DGConfig.h)

# Version information on windows
if (WIN32)
	configure_file("${ASSETS_DIR}/version.rc.in" version.rc)
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# By default we put binaries into this directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

# Set source files
file(GLOB SRC_FILES "${SOURCE_DIR}/*.cpp")

# Generate a `compile_commands.json` file for use with clang-based tools
# https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Cmake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(cmake/doxygen.cmake)
include(cmake/sphinx.cmake)
include(cmake/cppcheck.cmake)
include(cmake/clang-tidy.cmake)
include(cmake/clang-format.cmake)

add_executable(${PROJECT_NAME}
	$<$<PLATFORM_ID:Windows>:${ASSETS_DIR}/icon.rc>
	$<$<PLATFORM_ID:Windows>:${PROJECT_BINARY_DIR}/version.rc>
	${SRC_FILES})

# Enable warnings - inspired by: https://stackoverflow.com/a/50882216/3049315
target_compile_options(${PROJECT_NAME} PRIVATE
	$<$<CXX_COMPILER_ID:MSVC>:/W4 /WX>
	$<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -pedantic -Wmain -Weffc++ -Wswitch-default
		-Wswitch-enum -Wmissing-include-dirs -Wmissing-declarations -Wunreachable-code -Winline
		-Wfloat-equal -Wundef -Wcast-align -Wredundant-decls -Winit-self -Wshadow -Wnon-virtual-dtor
		-Wconversion -Wstrict-aliasing -Wold-style-cast>
	$<$<CXX_COMPILER_ID:GNU>:-Wzero-as-null-pointer-constant>
)

# Definitions
target_compile_definitions(${PROJECT_NAME} PRIVATE
	# Disable secure warnings on MSVC
	$<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS>
	$<$<PLATFORM_ID:Windows>:UNICODE _UNICODE>
)
# Note: NDEBUG is defined in the C standard, but DEBUG is not.
# Read comments: https://stackoverflow.com/a/8594122/3049315
# C standard section: http://port70.net/~nsz/c/c11/n1570.html#7.2

# Static compile on Windows for Release - inspired by: https://stackoverflow.com/a/24671474/3049315
# only makes sense for single-target generators, like Makefiles, see: https://stackoverflow.com/a/59314670/3049315
if (MINGW)
	target_link_libraries(${PROJECT_NAME} PRIVATE
		$<$<CONFIG:Release>:"-static-libgcc -static-libstdc++ -static">
	)
endif()

# For including the version in the binary.
# See: https://cmake.org/cmake/help/latest/guide/tutorial/A%20Basic%20Starting%20Point.html
target_include_directories(${PROJECT_NAME} PUBLIC "${PROJECT_BINARY_DIR}")

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
	COMMAND $<TARGET_FILE:${PROJECT_NAME}>)

include(cmake/memcheck.cmake)

#############
### CPACK ###
#############

# See: https://cmake.org/cmake/help/latest/guide/tutorial/Installing%20and%20Testing.html
install(TARGETS ${PROJECT_NAME} DESTINATION bin)

include(cmake/cpack_module.cmake)
