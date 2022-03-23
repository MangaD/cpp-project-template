# Inspired by:
# - http://www.stablecoder.ca/2018/01/01/cmake-clang-tools.html
# - https://github.com/libcpr/cpr/blob/master/cmake/clang-tidy.cmake

find_program(CLANG_TIDY "clang-tidy")
if(CLANG_TIDY)
	message(STATUS "-- clang-tidy found, static alanysis enabled through 'tidy' target.")

	file(GLOB_RECURSE ALL_CXX_SOURCE_FILES
		${SOURCE_DIR}/*.[ch]pp
		${SOURCE_DIR}/*.[ch]
	)

	add_custom_target(tidy
		COMMAND clang-tidy
		${ALL_CXX_SOURCE_FILES}
		-format-style=file
		--
		-std=c++${CMAKE_CXX_STANDARD}
		-I${PROJECT_BINARY_DIR}
	)
else ()
	message(WARNING "clang-tidy not found.")
endif()
