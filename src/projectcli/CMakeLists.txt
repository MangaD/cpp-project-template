file(GLOB SRC_FILES "*.cpp")

# Version information on windows
if (WIN32)
	set(ORIGINAL_FILE_NAME "${PROJECT_CLI_NAME}.exe")
	configure_file("${PACKAGING_DIR}/windows/version.rc.in" "${PROJECT_BINARY_DIR}/${PROJECT_CLI_NAME}_version.rc")
endif()

add_executable(${PROJECT_CLI_NAME}
	${SRC_FILES}
	$<$<PLATFORM_ID:Windows>:${PACKAGING_DIR}/windows/icon.rc>
	$<$<PLATFORM_ID:Windows>:${PROJECT_BINARY_DIR}/${PROJECT_CLI_NAME}_version.rc>)

# For including config.h and version.rc
# See: https://cmake.org/cmake/help/latest/guide/tutorial/A%20Basic%20Starting%20Point.html
target_include_directories(${PROJECT_CLI_NAME} PUBLIC "${PROJECT_BINARY_DIR}")

target_include_directories(${PROJECT_CLI_NAME} PUBLIC "${PROJECT_LIB_DIR}/src")

target_link_libraries(${PROJECT_CLI_NAME} PUBLIC ${PROJECT_LIB_NAME})

# Static compile on Windows for Release - inspired by: https://stackoverflow.com/a/24671474/3049315
# only makes sense for single-target generators, like Makefiles, see: https://stackoverflow.com/a/59314670/3049315
if (MINGW)
	target_link_libraries(${PROJECT_CLI_NAME} PRIVATE
		$<$<CONFIG:Release>:-static-libgcc -static-libstdc++ -static>
	)
elseif (MSVC OR
		(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND
		CMAKE_CXX_SIMULATE_ID STREQUAL "MSVC"))
	# MT vs MD vs MTd vs MDd https://social.msdn.microsoft.com/Forums/en-US/9474efb9-49cd-46e1-8935-ee2bebe95203/difference-in-mt-and-md-run-time-lib-setting?forum=vcgeneral
	# Might have to use MDd with wxWidgets because: https://forums.wxwidgets.org/viewtopic.php?t=47650
	set_property(TARGET ${PROJECT_CLI_NAME} PROPERTY
		MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
		#MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")

	# Clang's GNU frontend may not honor MSVC_RUNTIME_LIBRARY.
	# Explicitly select the corresponding static MSVC runtime.
	if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND
		CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "GNU")
		target_compile_options(${PROJECT_CLI_NAME} PRIVATE
			$<$<CONFIG:Release>:-fms-runtime-lib=static>
			$<$<CONFIG:Debug>:-fms-runtime-lib=static_dbg>
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
		target_link_options(${PROJECT_CLI_NAME} PRIVATE
			$<$<CONFIG:Release>:/INCREMENTAL:NO /NODEFAULTLIB:MSVCRT>
		)
	endif()
endif()


# Optionally set a different C++ standard for this target
#target_compile_features(server PRIVATE cxx_std_17)
#set_target_properties(server PROPERTIES CXX_EXTENSIONS OFF)

# Optionally set output directory for target:
#set_target_properties(target
#    PROPERTIES
#    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
#    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
#    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
#)
