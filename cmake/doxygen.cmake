# https://cmake.org/cmake/help/latest/module/FindDoxygen.html

find_package(Doxygen)

set(DOXYGEN_GENERATE_HTML YES CACHE BOOL "Generate Doxygen HTML")
set(DOXYGEN_GENERATE_LATEX YES CACHE BOOL "Generate Doxygen LaTeX")
set(DOXYGEN_GENERATE_XML YES) # Needed by Sphinx
set(DOXYGEN_USE_MDFILE_AS_MAINPAGE README.md)
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

	doxygen_add_docs(doxygen
		README.md
		${DOCS_DIR}/getting_started.md
		${DOCS_DIR}/install.md
		${DOCS_DIR}/development_guide.md
		LICENSE
		${SOURCE_DIR})
endif()
