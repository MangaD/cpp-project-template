#!/usr/local/bin/cmake -P

set(ENV{NINJA_STATUS} "[%f/%t %o/sec] ")

# Display ccache configuration.
execute_process(
    COMMAND ccache --show-config
    COMMAND_ERROR_IS_FATAL ANY
)

# Reset statistics before building.
execute_process(
    COMMAND ccache --zero-stats
    COMMAND_ERROR_IS_FATAL ANY
)

# Build the project.
execute_process(
    COMMAND cmake --build build --config $ENV{BUILD_TYPE}
    RESULT_VARIABLE result
    OUTPUT_VARIABLE output
    ERROR_VARIABLE error
    ECHO_OUTPUT_VARIABLE
    ECHO_ERROR_VARIABLE
)

# Display ccache statistics even if the build fails.
execute_process(
    COMMAND ccache --show-stats --verbose
)

if (NOT result EQUAL 0)
    message(FATAL_ERROR "Build failed with exit code ${result}")
endif()