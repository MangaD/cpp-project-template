### DEPENDENCIES

# https://docs.wxwidgets.org/trunk/overview_cmake.html
# https://wiki.wxwidgets.org/CMake
# Need to link against adv because using wxSplashScreen
# https://forums.wxwidgets.org/viewtopic.php?t=31482
# https://docs.wxwidgets.org/2.8/wx_librarieslist.html

file(GLOB SRC_FILES "*.cpp")

target_sources(${PROJECT_WX_NAME} PRIVATE
	${SRC_FILES}
	$<$<PLATFORM_ID:Windows>:${ASSETS_DIR}/icon.rc>
	$<$<PLATFORM_ID:Windows>:${PROJECT_BINARY_DIR}/version.rc>
)

target_compile_definitions(${PROJECT_WX_NAME} PUBLIC
    UNICODE _UNICODE wxUSE_DPI_AWARE_MANIFEST=2
)

# For including config.h and version.rc
# See: https://cmake.org/cmake/help/latest/guide/tutorial/A%20Basic%20Starting%20Point.html
target_include_directories(${PROJECT_WX_NAME} PUBLIC "${PROJECT_BINARY_DIR}")

target_include_directories(${PROJECT_WX_NAME} PUBLIC "${PROJECT_LIB_DIR}")

target_link_libraries(${PROJECT_WX_NAME} PUBLIC ${PROJECT_LIB_NAME})

target_link_libraries(${PROJECT_WX_NAME} PUBLIC ${wxWidgets_LIBRARIES})

# Static compile on Windows for Release - inspired by: https://stackoverflow.com/a/24671474/3049315
# only makes sense for single-target generators, like Makefiles, see: https://stackoverflow.com/a/59314670/3049315
if (MINGW)
	target_link_libraries(${PROJECT_WX_NAME} PRIVATE
		$<$<CONFIG:Release>:-static-libgcc -static-libstdc++ -static>
	)
    # https://stackoverflow.com/a/51602330/3049315
    target_link_libraries(${PROJECT_WX_NAME} PRIVATE
        $<$<CONFIG:Release>:-static gcc stdc++ winpthread -dynamic>
    )
elseif (MSVC)
	# MT vs MD vs MTd vs MDd https://social.msdn.microsoft.com/Forums/en-US/9474efb9-49cd-46e1-8935-ee2bebe95203/difference-in-mt-and-md-run-time-lib-setting?forum=vcgeneral
	# Might have to use MDd with wxWidgets because: https://forums.wxwidgets.org/viewtopic.php?t=47650
	set_property(TARGET ${PROJECT_WX_NAME} PROPERTY
		MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
		#MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")

	target_link_options(${PROJECT_WX_NAME} PUBLIC
		$<$<CONFIG:Release>:/INCREMENTAL:NO /NODEFAULTLIB:MSVCRT>
	)
endif()

# Bring project files to the executable's directory
file(COPY "${ASSETS_DIR}/images" DESTINATION "${PROJECT_BINARY_DIR}")