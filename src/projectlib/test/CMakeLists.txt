##############
# GoogleTest #
##############

find_package(GTest REQUIRED)

file(GLOB TEST_LIB_FILES "*.cpp")

add_executable("${PROJECT_LIB_NAME}_gtest" ${TEST_LIB_FILES})

target_include_directories("${PROJECT_LIB_NAME}_gtest" PUBLIC
	${GTEST_INCLUDE_DIRS}
	"${PROJECT_LIB_DIR}/src")

# Optionally link `GTest::gtest_main` to generate a default
# main function for us.
target_link_libraries("${PROJECT_LIB_NAME}_gtest"
	${GTEST_LIBRARIES})

if (MINGW)
	target_link_libraries("${PROJECT_LIB_NAME}_gtest" PRIVATE
		$<$<CONFIG:Release>:-static-libgcc -static-libstdc++ -static>
	)
elseif (MSVC)
	set_property(TARGET "${PROJECT_LIB_NAME}_gtest" PROPERTY
		MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
	target_link_options("${PROJECT_LIB_NAME}_gtest" PUBLIC
		$<$<CONFIG:Release>:/INCREMENTAL:NO /NODEFAULTLIB:MSVCRT>
	)
endif()

# Enable CMake's test runner to discover the tests
# included in the binary, using the GoogleTest CMake module.
include(GoogleTest)
gtest_discover_tests("${PROJECT_LIB_NAME}_gtest")
