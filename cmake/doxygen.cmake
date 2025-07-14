# https://cmake.org/cmake/help/latest/module/FindDoxygen.html

find_package(Doxygen)

set(DOXYGEN_ENABLE_PREPROCESSING NO) # https://stackoverflow.com/a/26043120/3049315

set(DOXYGEN_GENERATE_HTML YES CACHE BOOL "Generate Doxygen HTML")
set(DOXYGEN_GENERATE_LATEX YES CACHE BOOL "Generate Doxygen LaTeX")
set(DOXYGEN_GENERATE_XML YES) # Needed by Sphinx
set(DOXYGEN_PROJECT_NAME "${PROJECT_NAME}" CACHE INTERNAL "")
set(DOXYGEN_PROJECT_BRIEF "${PROJECT_DESCRIPTION}" CACHE INTERNAL "")
set(DOXYGEN_PROJECT_NUMBER "${PROJECT_VERSION}" CACHE INTERNAL "")
set(DOXYGEN_PROJECT_LOGO ${DOXYGEN_DIR}/logo.png)
set(DOXYGEN_PROJECT_ICON ${DOXYGEN_DIR}/logo.png)
set(DOXYGEN_OUTPUT_DIRECTORY ${DOXYGEN_DIR}/build)
set(DOXYGEN_EXTRACT_ALL YES)
set(DOXYGEN_EXTRACT_PRIVATE YES)
set(DOXYGEN_EXTRACT_STATIC YES)
set(DOXYGEN_EXTRACT_LOCAL_CLASSES YES)
set(DOXYGEN_FULL_PATH_NAMES YES)
set(DOXYGEN_WARN_IF_UNDOCUMENTED YES)
set(DOXYGEN_WARN_NO_PARAMDOC YES)
set(DOXYGEN_STRIP_FROM_PATH ${CMAKE_SOURCE_DIR})
set(DOXYGEN_RECURSIVE YES)
set(DOXYGEN_GENERATE_TREEVIEW YES) # Required by doxygen-awesome-css
set(DOXYGEN_DISABLE_INDEX NO) # Required by doxygen-awesome-css
set(DOXYGEN_FULL_SIDEBAR NO) # Required by doxygen-awesome-css
set(DOXYGEN_HTML_COLORSTYLE "TOGGLE")

# === Doxygen Awesome CSS
if(DOXYGEN_VERSION VERSION_LESS 1.14.0)
    if(NOT EXISTS "${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome.css")
        message(WARNING "doxygen-awesome-css submodule not found. Did you run `git submodule update --init --recursive`?")
    endif()
	set(DOXYGEN_HTML_COLORSTYLE LIGHT) # Required by doxygen-awesome-css
	set(DOXYGEN_HTML_HEADER ${DOXYGEN_DIR}/header.html)
	set(DOXYGEN_HTML_FOOTER ${DOXYGEN_DIR}/footer.html)
	set(DOXYGEN_HTML_EXTRA_FILES
		${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-darkmode-toggle.js
		${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-fragment-copy-button.js
		${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-paragraph-link.js
		${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-interactive-toc.js
		${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-tabs.js)
	set(DOXYGEN_HTML_EXTRA_STYLESHEET
		${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome.css
		${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-sidebar-only.css
		${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-sidebar-only-darkmode-toggle.css)
endif()


if (DOXYGEN_FOUND)
	message(STATUS "-- Doxygen documentation enabled through 'doxygen' target.")

	set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${CMAKE_SOURCE_DIR}/README.md")
	file(GLOB md_files "${CMAKE_SOURCE_DIR}/docs/*.md")

	# Make these files available to Doxygen
	set(DOXYGEN_HTML_EXTRA_FILES
		${DOXYGEN_HTML_EXTRA_FILES}
		${CMAKE_SOURCE_DIR}/LICENSE
	)

	doxygen_add_docs(doxygen
		${md_files}
		README.md
		LICENSE
		${SOURCE_DIR})
endif()
