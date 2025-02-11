# https://cmake.org/cmake/help/latest/module/FindDoxygen.html

find_package(Doxygen)

set(DOXYGEN_GENERATE_HTML YES CACHE BOOL "Generate Doxygen HTML")
set(DOXYGEN_GENERATE_LATEX YES CACHE BOOL "Generate Doxygen LaTeX")
set(DOXYGEN_GENERATE_XML YES) # Needed by Sphinx
set(DOXYGEN_PROJECT_LOGO ${DOXYGEN_DIR}/logo.png)
set(DOXYGEN_OUTPUT_DIRECTORY ${DOXYGEN_DIR}/build)
set(DOXYGEN_GENERATE_TREEVIEW YES) # Required by doxygen-awesome-css
set(DOXYGEN_DISABLE_INDEX NO) # Required by doxygen-awesome-css
set(DOXYGEN_FULL_SIDEBAR NO) # Required by doxygen-awesome-css
set(DOXYGEN_HTML_COLORSTYLE LIGHT) # Required by doxygen-awesome-css
set(DOXYGEN_HTML_HEADER ${DOXYGEN_DIR}/header.html)
set(DOXYGEN_HTML_FOOTER ${DOXYGEN_DIR}/footer.html)
set(DOXYGEN_HTML_EXTRA_FILES
	${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
	${DOXYGEN_DIR}/logo.png
	${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-darkmode-toggle.js
	${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-fragment-copy-button.js
	${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-paragraph-link.js
	${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-interactive-toc.js
	${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-tabs.js)
set(DOXYGEN_HTML_EXTRA_STYLESHEET
	${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome.css
	${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-sidebar-only.css
	${DOXYGEN_DIR}/doxygen-awesome-css/doxygen-awesome-sidebar-only-darkmode-toggle.css)

set(DOXYGEN_IMAGE_PATH ${DOXYGEN_DIR}/logo.png)

if (DOXYGEN_FOUND)
	message(STATUS "-- Doxygen documentation enabled through 'doxygen' target.")

	# Add Table of Contents to markdown files
	file(GLOB md_files ${CMAKE_SOURCE_DIR}/docs/*.md)

    file(COPY ${CMAKE_SOURCE_DIR}/README.md DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/md_files")
	file(COPY ${md_files} DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/md_files/docs")

    file(GLOB_RECURSE md_files "${CMAKE_CURRENT_BINARY_DIR}/md_files/*.md")
    foreach(filename ${md_files})
        file(READ ${filename} MD_TEXT)
        # Insert [TOC] immediately after the first level-1 header line.
        string(REGEX REPLACE "^(# [^\n]+)\r?\n(.+)" "\\1\n[TOC]\n\\2" MD_TEXT_MODIFIED "${MD_TEXT}")
        file(WRITE ${filename} "${MD_TEXT_MODIFIED}")
    endforeach()

	set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${CMAKE_CURRENT_BINARY_DIR}/md_files/README.md")

	doxygen_add_docs(doxygen
		${md_files}
		LICENSE
		${SOURCE_DIR})
endif()
