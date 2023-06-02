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
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_DESCRIPTION ${PROJECT_DESCRIPTION})
set(CPACK_PACKAGE_VERSION_MAJOR ${CMAKE_PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${CMAKE_PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${CMAKE_PROJECT_VERSION_PATCH})
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

if(BUILD_PROJECTWX)
	set(CPACK_PACKAGE_EXECUTABLES "${PROJECT_WX_NAME}" "${PROJECT_WX_NAME}" ) # exe name followed by shortcut text
	set(CPACK_CREATE_DESKTOP_LINKS "${PROJECT_WX_NAME}")
endif()

# Inspired by: https://dev.to/theprogrammerdavid/packaging-with-cmake-cpack-and-nsis-on-windows-4gnb
# Also see: https://cmake.org/cmake/help/latest/cpack_gen/nsis.html
if(WIN32)
	set(CPACK_NSIS_MANIFEST_DPI_AWARE ON)
	set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
	set(CPACK_NSIS_MODIFY_PATH ON)
	set(CPACK_NSIS_HELP_LINK ${CMAKE_PROJECT_HOMEPAGE_URL})
	set(CPACK_NSIS_URL_INFO_ABOUT ${CMAKE_PROJECT_HOMEPAGE_URL})
	#set(CPACK_NSIS_CONTACT ${APP_EMAIL})

	## Shortcuts
	set (CPACK_NSIS_MENU_LINKS
		"share/docs/${PROJECT_NAME}/README.md" "README"
		"${CMAKE_PROJECT_HOMEPAGE_URL}" "${PROJECT_NAME} Web Site")
	#set(CPACK_NSIS_CREATE_ICONS_EXTRA
	#	"CreateShortCut '$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\${PROJECT_WX_NAME}.lnk' '$INSTDIR\\\\bin\\\\${PROJECT_WX_NAME}.exe' "
	#)

	## Look & Feel
	set(CPACK_NSIS_MUI_ICON "${ASSETS_DIR}/icon.ico")
	set(CPACK_NSIS_MUI_UNIICON "${ASSETS_DIR}/icon.ico")
	set(CPACK_NSIS_INSTALLED_ICON_NAME "${ASSETS_DIR}/icon.ico")
	# The bitmap has some tricks to work: https://stackoverflow.com/a/28768495/3049315
	# With GIMP, when exporting BMP, expand "compatibility options" and tick
	# "Do not write color space information". Tick 24 bits.
	# If using imagemagick, do: convert banner.bmp BMP3:banner.bmp
	# Path must have 4 backspaces
	set(CPACK_PACKAGE_ICON "${ASSETS_DIR}/nsis\\\\icon.bmp")
	set(CPACK_NSIS_MUI_WELCOMEFINISHPAGE_BITMAP "${ASSETS_DIR}/nsis\\\\welcomefinishpage.bmp")
	set(CPACK_NSIS_MUI_UNWELCOMEFINISHPAGE_BITMAP "${ASSETS_DIR}/nsis\\\\welcomefinishpage.bmp")
	set(CPACK_NSIS_MUI_FINISHPAGE_RUN "${PROJECT_WX_NAME}")

	## LICENSE
	# Remove single new lines in license
	file(STRINGS LICENSE LICENSE NEWLINE_CONSUME ENCODING "UTF-8")
	string(REGEX REPLACE "\n\n" "#CMAKE_DOUBLE_NEWLINE#" LICENSE "${LICENSE}") # keep double newlines
	string(REGEX REPLACE "\n" " " LICENSE "${LICENSE}") # remove single newlines
	string(REGEX REPLACE "#CMAKE_DOUBLE_NEWLINE#" "\n\n" LICENSE "${LICENSE}") # keep double newlines
	file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/License.txt" ${LICENSE})
	# Convert license encoding to UTF-8 with BOM, because:
	# https://gitlab.kitware.com/cmake/cmake/-/issues/21318
	execute_process(COMMAND cscript "${CMAKE_CURRENT_SOURCE_DIR}/cmake/utf8_to_utf8bom.vbs" "${CMAKE_CURRENT_BINARY_DIR}/License.txt" "${CMAKE_CURRENT_BINARY_DIR}/License_utf8bom.txt")
	set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_BINARY_DIR}/License_utf8bom.txt")

	## VERSION
	if(${PROJECT_LANGUAGE_NEUTRAL} EQUAL 0)
		# https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows?view=windows-11
		set(VER_VERSION_LANG "1033") # ENGLISH_US
	else()
		set(VER_VERSION_LANG "0") # LANG_NEUTRAL
	endif()

	set (CPACK_NSIS_DEFINES 
		"${CPACK_NSIS_DEFINES}
		VIProductVersion ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}.${CMAKE_PROJECT_VERSION_TWEAK}
		VIFileVersion ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}.${CMAKE_PROJECT_VERSION_TWEAK}
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"CompanyName\\\" \\\"${CPACK_PACKAGE_VENDOR}\\\"
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"FileDescription\\\" \\\"${PROJECT_DESCRIPTION} Installer\\\"
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"FileVersion\\\" \\\"v${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}.${CMAKE_PROJECT_VERSION_TWEAK}\\\"
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"InternalName\\\" \\\"${CPACK_PACKAGE_NAME} Installer\\\"
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"LegalCopyright\\\" \\\"${CPACK_PACKAGE_COPYRIGHT}\\\"
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"OriginalFilename\\\" \\\"${CPACK_PACKAGE_FILE_NAME}.exe\\\"
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"ProductName\\\" \\\"${CPACK_PACKAGE_NAME}\\\"
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"ProductVersion\\\" \\\"v${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}.${CMAKE_PROJECT_VERSION_TWEAK}\\\"
		VIAddVersionKey /LANG=${VER_VERSION_LANG} \\\"Comments\\\" \\\"${CPACK_PACKAGE_DESCRIPTION}\\\""
	)
else()
	set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.32), libstdc++6 (>= 3.4.29)")
endif()

install(FILES ${CPACK_RESOURCE_FILE_README} ${CPACK_RESOURCE_FILE_LICENSE}
	DESTINATION share/docs/${PROJECT_NAME})

include(CPack)
