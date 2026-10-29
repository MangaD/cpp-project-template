#!/usr/local/bin/cmake -P

set(path_separator ":")
if ("$ENV{RUNNER_OS}" STREQUAL "Windows")
	set(path_separator ";")
endif()
set(ENV{PATH} "$ENV{GITHUB_WORKSPACE}${path_separator}$ENV{PATH}")

# Select an explicit compiler target when cross-compiling with Clang on Windows.
# Other matrix configurations continue using their compiler defaults.
set(compiler_target_args)

if(NOT "$ENV{COMPILER_TARGET}" STREQUAL "")
    list(APPEND compiler_target_args
        "-D CMAKE_C_COMPILER_TARGET=$ENV{COMPILER_TARGET}"
        "-D CMAKE_CXX_COMPILER_TARGET=$ENV{COMPILER_TARGET}"
    )
endif()

if ("$ENV{RUNNER_OS}" STREQUAL "Windows")
	file(TO_CMAKE_PATH "$ENV{GITHUB_WORKSPACE}/vcpkg/scripts/buildsystems/vcpkg.cmake" toolchain_file)
	execute_process(
		COMMAND cmake
			-S .
			-B build
			-D CMAKE_BUILD_TYPE=$ENV{BUILD_TYPE}
			-G "Ninja"
			-D CMAKE_MAKE_PROGRAM=ninja
			-D CMAKE_C_COMPILER_LAUNCHER=ccache
			-D CMAKE_CXX_COMPILER_LAUNCHER=ccache
			-D CMAKE_TOOLCHAIN_FILE=${toolchain_file}
			-D VCPKG_TARGET_TRIPLET=$ENV{VCPKG_TRIPLET}
			-D VCPKG_HOST_TRIPLET=$ENV{VCPKG_TRIPLET}
			-D VCPKG_MANIFEST_MODE=OFF
			${compiler_target_args}
			--fresh # Necessary if changing between build types
		RESULT_VARIABLE result
	)
else()
	execute_process(
		COMMAND cmake
			-S .
			-B build
			-D CMAKE_BUILD_TYPE=$ENV{BUILD_TYPE}
			-G "Ninja"
			-D CMAKE_MAKE_PROGRAM=ninja
			-D CMAKE_C_COMPILER_LAUNCHER=ccache
			-D CMAKE_CXX_COMPILER_LAUNCHER=ccache
			--fresh # Necessary if changing between build types
		RESULT_VARIABLE result
	)
endif()

if (NOT result EQUAL 0)
	message(FATAL_ERROR "Bad exit status")
endif()
