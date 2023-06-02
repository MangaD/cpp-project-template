# Taken from: https://github.com/duckie/cpp_project_template/blob/master/cmake/ProjectGlobalMacros.cmake

# Consider using this project: https://github.com/arsenm/sanitizers-cmake
# Also read: https://developers.redhat.com/blog/2021/05/05/memory-error-checking-in-c-and-c-comparing-sanitizers-and-valgrind

if (DEFINED PROJECT_BUILD_SANITIZER_TYPE)
	if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
		set(SAN ${PROJECT_BUILD_SANITIZER_TYPE})
		if (NOT ${SAN} STREQUAL "")
			if (${SAN} STREQUAL "address"
					OR ${SAN} STREQUAL "memory"
					OR ${SAN} STREQUAL "thread"
					OR ${SAN} STREQUAL "undefined"
					OR ${SAN} STREQUAL "leak")
				add_compile_options(-fsanitize=${SAN} -fsanitize-blacklist=${PROJECT_SOURCE_DIR}/SanitizerBlacklist.txt)
				target_link_libraries(${PROJECT_CLI_NAME} PRIVATE "-fsanitize=${SAN} -fsanitize-blacklist=${PROJECT_SOURCE_DIR}/SanitizerBlacklist.txt")
				target_link_libraries(${PROJECT_WX_NAME} PRIVATE "-fsanitize=${SAN} -fsanitize-blacklist=${PROJECT_SOURCE_DIR}/SanitizerBlacklist.txt")
			else()
				message(FATAL_ERROR "Clang sanitizer ${SAN} is unknown.")
			endif()
		endif()
	endif()
	if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "GNU")
		set(SAN ${PROJECT_BUILD_SANITIZER_TYPE})
		if (NOT ${SAN} STREQUAL "")
			if (${SAN} STREQUAL "address"
					OR ${SAN} STREQUAL "thread"
					OR ${SAN} STREQUAL "undefined"
					OR ${SAN} STREQUAL "leak")
				add_compile_options(-fsanitize=${SAN})
				target_link_libraries(${PROJECT_CLI_NAME} PRIVATE "-fsanitize=${SAN} -llsan")
				target_link_libraries(${PROJECT_WX_NAME} PRIVATE "-fsanitize=${SAN} -llsan")
			else()
				message(FATAL_ERROR "GCC sanitizer ${SAN} is unknown.")
			endif()
		endif()
	endif()
endif()
