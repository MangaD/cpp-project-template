#!/usr/local/bin/cmake -P

include(ProcessorCount)
ProcessorCount(N)

set(ENV{CTEST_OUTPUT_ON_FAILURE} "ON")

# CDash: https://cmake.org/cmake/help/book/mastering-cmake/chapter/CDash.html
# ctest -D Continuous
# performs the start, update, configure, build, test, coverage, and submit commands.
set(CTEST_STEPS Start Update Configure Build Test)

# Conditionally add MemCheck for Linux
if("$ENV{RUNNER_OS}" STREQUAL "Linux")
  list(APPEND CTEST_STEPS MemCheck)
endif()

# Conditionally add Coverage for gcc
if("$ENV{CC}" STREQUAL "gcc")
  list(APPEND CTEST_STEPS Coverage)
endif()

# Always add Submit step
list(APPEND CTEST_STEPS Submit)

# Execute each CTest step individually
foreach(step IN LISTS CTEST_STEPS)
  execute_process(
    COMMAND ctest -j ${N} -C $ENV{BUILD_TYPE} -D Continuous${step}
    WORKING_DIRECTORY build
    RESULT_VARIABLE result
    OUTPUT_VARIABLE output
    ERROR_VARIABLE output
    ECHO_OUTPUT_VARIABLE ECHO_ERROR_VARIABLE
  )
  if(NOT result EQUAL 0)
    string(REGEX MATCH "[0-9]+% tests.*[0-9.]+ sec.*$" test_results "${output}")
    string(REPLACE "\n" "%0A" test_results "${test_results}")
    message("::error::${test_results}")
    message(FATAL_ERROR "Running ctest -D Continuous${step} failed!")
  endif()
endforeach()
