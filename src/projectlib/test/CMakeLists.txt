##############
# GoogleTest #
##############

find_package(GTest REQUIRED)

file(GLOB TEST_LIB_FILES "*.cpp")

add_executable("${PROJECT_LIB_NAME}_gtest" ${TEST_LIB_FILES})

target_include_directories("${PROJECT_LIB_NAME}_gtest" PUBLIC
	${GTEST_INCLUDE_DIRS}
	"${PROJECT_LIB_DIR}/src")

# 1. Optionally link `GTest::gtest_main` to generate a default
# main function for us.
# 2. May need to link with -pthread on some operating systems
# (tested with Raspbian). See: https://stackoverflow.com/a/21116684/3049315
target_link_libraries("${PROJECT_LIB_NAME}_gtest" PRIVATE
	${GTEST_LIBRARIES} -pthread)

if (MINGW)
	target_link_libraries("${PROJECT_LIB_NAME}_gtest" PRIVATE
		$<$<CONFIG:Release>:-static-libgcc -static-libstdc++ -static>
	)
elseif (MSVC)
	# Must use DebugDLL in Debug mode because: https://stackoverflow.com/a/66307196/3049315
	set_property(TARGET "${PROJECT_LIB_NAME}_gtest" PROPERTY
		MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:DebugDLL>")
	target_link_options("${PROJECT_LIB_NAME}_gtest" PUBLIC
		$<$<CONFIG:Release>:/INCREMENTAL:NO /NODEFAULTLIB:MSVCRT>
	)
endif()

# Enable CMake's test runner to discover the tests
# included in the binary, using the GoogleTest CMake module.
include(GoogleTest)
gtest_discover_tests("${PROJECT_LIB_NAME}_gtest")
