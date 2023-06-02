# https://cmake.org/cmake/help/latest/module/FindDoxygen.html

find_package(Doxygen)

set(DOXYGEN_GENERATE_HTML YES)
set(DOXYGEN_GENERATE_LATEX YES)
set(DOXYGEN_GENERATE_XML YES)
set(DOXYGEN_USE_MDFILE_AS_MAINPAGE YES)
set(DOXYGEN_PROJECT_LOGO ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/logo.png)
set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/build)
set(DOXYGEN_GENERATE_TREEVIEW YES) # Required by doxygen-awesome-css
set(DOXYGEN_HTML_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/header.html)
set(DOXYGEN_HTML_FOOTER ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/footer.html)
set(DOXYGEN_HTML_EXTRA_FILES ${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-darkmode-toggle.js)
set(DOXYGEN_HTML_EXTRA_STYLESHEET
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome.css
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-sidebar-only.css
	${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/doxygen-awesome-css/doxygen-awesome-sidebar-only-darkmode-toggle.css)

if (DOXYGEN_FOUND)
	message(STATUS "-- Doxygen documentation enabled through 'doxygen' target.")

	doxygen_add_docs(doxygen
		README.md
		${SOURCE_DIR})
endif()
