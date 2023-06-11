# https://cmake.org/cmake/help/latest/module/FindDoxygen.html

find_package(Doxygen)

set(DOXYGEN_GENERATE_HTML YES CACHE BOOL "Generate Doxygen HTML")
set(DOXYGEN_GENERATE_LATEX YES CACHE BOOL "Generate Doxygen LaTeX")
set(DOXYGEN_GENERATE_XML YES) # Needed by Sphinx
set(DOXYGEN_USE_MDFILE_AS_MAINPAGE README.md)
set(DOXYGEN_PROJECT_LOGO ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/logo.png)
set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/build)
set(DOXYGEN_GENERATE_TREEVIEW YES) # Required by doxygen-awesome-css
set(DOXYGEN_DISABLE_INDEX NO) # Required by doxygen-awesome-css
set(DOXYGEN_FULL_SIDEBAR NO) # Required by doxygen-awesome-css
set(DOXYGEN_HTML_COLORSTYLE LIGHT) # Required by doxygen-awesome-css
set(DOXYGEN_HTML_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/header.html)
set(DOXYGEN_HTML_FOOTER ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/footer.html)
set(DOXYGEN_HTML_EXTRA_FILES 
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-darkmode-toggle.js
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-fragment-copy-button.js
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-paragraph-link.js
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-interactive-toc.js)
set(DOXYGEN_HTML_EXTRA_STYLESHEET
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome.css
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-sidebar-only.css
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-sidebar-only-darkmode-toggle.css)

if (DOXYGEN_FOUND)
	message(STATUS "-- Doxygen documentation enabled through 'doxygen' target.")

	doxygen_add_docs(doxygen
		README.md
		docs/getting_started.md
		docs/install.md
		docs/development_guide.md
		LICENSE
		${SOURCE_DIR})
endif()
