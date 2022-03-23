# Note: Cannot name this module 'cpack.cmake' because it will not work on Windows

# Taken from:
# - https://cmake.org/cmake/help/latest/guide/tutorial/Packaging%20an%20Installer.html
# - https://www.scivision.dev/cmake-cpack-basic/

# Deep Tutorial: https://cmake.org/cmake/help/book/mastering-cmake/chapter/Packaging%20With%20CPack.html

# do this after all install(...) commands so that all targets are finalized.
# Essentially, the last thing included at the end of the top-level CMakeLists.txt

include(InstallRequiredSystemLibraries)

#set(_fmt TGZ)
#if(WIN32)
	#set(_fmt ZIP)
#endif()
#set(CPACK_GENERATOR ${_fmt})
#set(CPACK_SOURCE_GENERATOR ${_fmt})
set(CPACK_PACKAGE_VERSION_MAJOR "${cpp-project-template_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${cpp-project-template_VERSION_MINOR}")
set(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/package")
set(CPACK_PACKAGE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
string(TOLOWER ${CMAKE_SYSTEM_NAME} _sys)
string(TOLOWER ${PROJECT_NAME} _project_lower)
set(CPACK_PACKAGE_FILE_NAME "${_project_lower}-${_sys}")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${_project_lower}-${PROJECT_VERSION}")

# not .gitignore as its regex syntax is distinct
file(READ ${CMAKE_CURRENT_LIST_DIR}/.cpack_ignore _cpack_ignore)
string(REGEX REPLACE "\n" ";" _cpack_ignore ${_cpack_ignore})
set(CPACK_SOURCE_IGNORE_FILES "${_cpack_ignore}")

# Taken from: https://dev.to/theprogrammerdavid/packaging-with-cmake-cpack-and-nsis-on-windows-4gnb
# Also see: https://cmake.org/cmake/help/latest/cpack_gen/nsis.html
# TODO: Unicode text in NSIS (e.g. License, character ç shows wrong). LICENSE should be converted to UTF-16LE
if(WIN32)
	set(CPACK_NSIS_INSTALLED_ICON_NAME "${ASSETS_DIR}/icon.ico")
	# The banner has some tricks to work: https://stackoverflow.com/a/28768495/3049315
	# With GIMP, when exporting BMP, expand "compatibility options" and tick
	# "Do not write color space information". Tick 24 bits.
	# If using imagemagick, do: convert banner.bmp BMP3:banner.bmp
	# Path must have 4 backspaces
	set(CPACK_PACKAGE_ICON "${ASSETS_DIR}/nsis\\\\banner.bmp")
	set(CPACK_NSIS_HELP_LINK ${CMAKE_PROJECT_HOMEPAGE_URL})
	set(CPACK_NSIS_URL_INFO_ABOUT ${CMAKE_PROJECT_HOMEPAGE_URL})
	#set(CPACK_NSIS_CONTACT ${APP_EMAIL})

	# Shortcut:
	set (CPACK_PACKAGE_EXECUTABLES "${PROJECT_NAME}" "${PROJECT_NAME}" ) # exe name followed by shortcut text
	set (CPACK_NSIS_MENU_LINKS
		"share/docs/${PROJECT_NAME}/README.md" "README"
		"${CMAKE_PROJECT_HOMEPAGE_URL}" "${PROJECT_NAME} Web Site")
	#set(CPACK_NSIS_CREATE_ICONS_EXTRA
	#	"CreateShortCut '$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\${PROJECT_NAME}.lnk' '$INSTDIR\\\\bin\\\\${PROJECT_NAME}.exe' "
	#)

	set(CPACK_NSIS_MUI_ICON "${ASSETS_DIR}/icon.ico")
	set(CPACK_NSIS_MANIFEST_DPI_AWARE ON)
else()
	set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.32), libstdc++6 (>= 3.4.29)")
endif()

install(FILES ${CPACK_RESOURCE_FILE_README} ${CPACK_RESOURCE_FILE_LICENSE}
	DESTINATION share/docs/${PROJECT_NAME})

include(CPack)
