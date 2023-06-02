# Inspired by:
# - https://github.com/duckie/cpp_project_template/blob/master/cmake/ProjectGlobalMacros.cmake
# - https://stackoverflow.com/a/40437731/3049315

if (WIN32)
	message(STATUS "-- valgrind not supported on Windows.")
else()

	find_program(MEMORYCHECK_COMMAND valgrind)

	# Format the whole source code with clang-format
	if (MEMORYCHECK_COMMAND)
		message(STATUS "-- valgrind found, memory check enabled through 'test_memcheck' target.")

		if (NOT MSVC)
			set(MEMORYCHECK_COMMAND_OPTIONS "--trace-children=yes --leak-check=full --track-origins=yes")
			set(MEMORYCHECK_SUPPRESSIONS_FILE "${PROJECT_SOURCE_DIR}/.valgrind_suppress.txt")
		endif()

		add_custom_target(test_memcheck
			COMMAND ${CMAKE_CTEST_COMMAND}
				--force-new-ctest-process --test-action memcheck
			COMMAND cat "${CMAKE_BINARY_DIR}/Testing/Temporary/MemoryChecker.*.log"
			WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")
	endif()

endif()