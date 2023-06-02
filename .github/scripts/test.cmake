#!/usr/local/bin/cmake -P

include(ProcessorCount)
ProcessorCount(N)

set(ENV{CTEST_OUTPUT_ON_FAILURE} "ON")

# CDash: https://cmake.org/cmake/help/book/mastering-cmake/chapter/CDash.html
# ctest -D Continuous
# performs the start, update, configure, build, test, coverage, and submit commands.
set(DoCovMemChk "-D ContinuousStart -D ContinuousUpdate -D ContinuousConfigure -D ContinuousBuild -D ContinuousTest")
# MemoryCheck
# Perform memory checks using Purify or valgrind.
if ("$ENV{RUNNER_OS}" STREQUAL "Linux" )
	set(DoCovMemChk "${DoCovMemChk} -D ContinuousMemCheck")
endif()
# Coverage
# Collect source code coverage information using gcov or Bullseye.
if ("$ENV{CC}" STREQUAL "gcc" )
	set(DoCovMemChk "${DoCovMemChk} -D ContinuousCoverage")
endif()
set(DoCovMemChk "${DoCovMemChk} -D ContinuousSubmit")

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