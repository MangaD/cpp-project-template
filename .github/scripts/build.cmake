#!/usr/local/bin/cmake -P

set(ENV{NINJA_STATUS} "[%f/%t %o/sec] ")

if ("$ENV{RUNNER_OS}" STREQUAL "Windows" AND NOT "x$ENV{ENVIRONMENT_SCRIPT}" STREQUAL "x")
	file(STRINGS environment_script_output.txt output_lines)
	foreach(line IN LISTS output_lines)
		if (line MATCHES "^([a-zA-Z0-9_-]+)=(.*)$")
			set(ENV{${CMAKE_MATCH_1}} "${CMAKE_MATCH_2}")
		endif()
	endforeach()
endif()

file(TO_CMAKE_PATH "$ENV{GITHUB_WORKSPACE}" ccache_basedir)
set(ENV{CCACHE_BASEDIR} "${ccache_basedir}")
set(ENV{CCACHE_DIR} "${ccache_basedir}/.ccache")
set(ENV{CCACHE_COMPRESS} "true")
set(ENV{CCACHE_COMPRESSLEVEL} "6")
set(ENV{CCACHE_MAXSIZE} "400M")
if ("$ENV{CXX}" STREQUAL "cl")
	set(ENV{CCACHE_MAXSIZE} "600M")
endif()

execute_process(COMMAND ccache -p)
execute_process(COMMAND ccache -z)

execute_process(
	COMMAND cmake --build build --config $ENV{BUILD_TYPE}
	RESULT_VARIABLE result
	OUTPUT_VARIABLE output
	ERROR_VARIABLE output
	ECHO_OUTPUT_VARIABLE ECHO_ERROR_VARIABLE
)
if (NOT result EQUAL 0)
	string(REGEX MATCH "FAILED:.*$" error_message "${output}")
	string(REPLACE "\n" "%0A" error_message "${error_message}")
	message("::error::${error_message}")
	message(FATAL_ERROR "Build failed")
endif()