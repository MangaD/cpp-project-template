find_program(CLANG_FORMAT "clang-format")

# Format the whole source code with clang-format
if (CLANG_FORMAT)
	message(STATUS "Found clang-format: ${CLANG_FORMAT}")
	message(STATUS "-- Source formatting with clang-format enabled through 'format' target.")

	file(GLOB_RECURSE ALL_CXX_SOURCE_FILES
		${SOURCE_DIR}/*.[ch]pp
		${SOURCE_DIR}/*.[ch]
	)
	add_custom_target(format
		COMMAND clang-format
		-i
		-style=file
		${ALL_CXX_SOURCE_FILES}
	)
endif()
