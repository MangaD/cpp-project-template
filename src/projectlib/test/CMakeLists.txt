##############
# GoogleTest #
##############

find_package(GTest REQUIRED)
find_package(Threads REQUIRED)

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
	${GTEST_LIBRARIES}
	Threads::Threads)

if (MINGW)
	target_link_libraries("${PROJECT_LIB_NAME}_gtest" PRIVATE
		$<$<CONFIG:Release>:-static-libgcc -static-libstdc++ -static>
	)
elseif (MSVC OR
		(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND
		CMAKE_CXX_SIMULATE_ID STREQUAL "MSVC"))
	# MT vs MD vs MTd vs MDd https://social.msdn.microsoft.com/Forums/en-US/9474efb9-49cd-46e1-8935-ee2bebe95203/difference-in-mt-and-md-run-time-lib-setting?forum=vcgeneral
	# Might have to use MDd with wxWidgets because: https://forums.wxwidgets.org/viewtopic.php?t=47650
	# This may require a custom triplet for vcpkg to build GTest with the same CRT linkage as the project.
	set_property(TARGET "${PROJECT_LIB_NAME}_gtest" PROPERTY
		MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
		#MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")

	# Clang's GNU frontend may not honor MSVC_RUNTIME_LIBRARY.
	# Explicitly select the corresponding MSVC runtime.
	if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND
		CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "GNU")
		target_compile_options("${PROJECT_LIB_NAME}_gtest" PRIVATE
			$<$<CONFIG:Release>:-fms-runtime-lib=static>
			$<$<CONFIG:Debug>:-fms-runtime-lib=static_dbg>
			#$<$<CONFIG:Debug>:-fms-runtime-lib=dll_dbg>
		)
	else()
		# Disable incremental linking in Release builds to allow full linker
		# optimizations and avoid incremental-link padding and overhead.
		#
		# Ignore automatic requests for MSVCRT.lib (the dynamic Release CRT
		# import library), since our Release builds use the static MSVC runtime
		# (/MT) to match the vcpkg dependencies.
		#
		# This does not disable the UCRT or fix objects compiled with /MD;
		# all linked objects must use compatible CRT settings.
		target_link_options("${PROJECT_LIB_NAME}_gtest" PRIVATE
			$<$<CONFIG:Release>:/INCREMENTAL:NO /NODEFAULTLIB:MSVCRT>
		)
	endif()
endif()

# Enable CMake's test runner to discover the tests
# included in the binary, using the GoogleTest CMake module.
include(GoogleTest)

# GoogleTest discovery executes the test binary during the build.
gtest_discover_tests("${PROJECT_LIB_NAME}_gtest" DISCOVERY_TIMEOUT 60)