#!/usr/local/bin/cmake -P

include(ProcessorCount)
ProcessorCount(N)

set(ENV{CTEST_OUTPUT_ON_FAILURE} "ON")

set(DoCovMemChk "")
if ("$ENV{RUNNER_OS}" STREQUAL "Linux" AND "$ENV{BUILD_TYPE}" STREQUAL "Coverage")
	set(DoCovMemChk "-D Continuous -T Test -T Coverage -T memcheck")
endif()

execute_process(
	COMMAND ctest -j ${N} -C $ENV{BUILD_TYPE} ${DoCovMemChk}
	WORKING_DIRECTORY build
	RESULT_VARIABLE result
	OUTPUT_VARIABLE output
	ERROR_VARIABLE output
	ECHO_OUTPUT_VARIABLE ECHO_ERROR_VARIABLE
)
if (NOT result EQUAL 0)
	string(REGEX MATCH "[0-9]+% tests.*[0-9.]+ sec.*$" test_results "${output}")
	string(REPLACE "\n" "%0A" test_results "${test_results}")
	message("::error::${test_results}")
	message(FATAL_ERROR "Running tests failed!")
endif()