# Inspired by:
# - https://stackoverflow.com/a/48630368/3049315
# - https://github.com/libcpr/cpr/blob/master/cmake/cppcheck.cmake

find_program(CPPCHECK "cppcheck")

if (CPPCHECK)
	message(STATUS "-- cppcheck found, static alanysis enabled through 'cppcheck' target.")

	add_custom_target(cppcheck
		COMMAND cppcheck
		${SOURCE_DIR}
		--enable=all
		--force
		--inline-suppr
		--std=c++${CMAKE_CXX_STANDARD}
		--suppressions-list=${CMAKE_SOURCE_DIR}/CppCheckSuppressions.txt
		--library=wxwidgets
		-I${PROJECT_BINARY_DIR}
		-I${PROJECT_LIB_DIR}
	)

else()
	message(WARNING "cppcheck not found.")
endif()
