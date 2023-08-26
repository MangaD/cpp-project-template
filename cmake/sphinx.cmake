# Taken from: https://www.vortech.nl/en/integrating-sphinx-in-cmake/

find_package(Sphinx COMPONENTS breathe sphinx_rtd_theme)

set(SPHINX_AUTHOR ${AUTHOR_NAME}) # If omitted, will be "@PROJECT_NAME@'s committers"

if(Sphinx_FOUND)
	message(STATUS "-- Sphinx documentation enabled through 'sphinx' target.")

	configure_file("${SPHINX_DIR}/index.rst.in" "${SPHINX_DIR}/index.rst")

	sphinx_add_docs(
		sphinx
		BREATHE_PROJECTS doxygen
		BUILDER html
		SOURCE_DIRECTORY "${SPHINX_DIR}"
		OUTPUT_DIRECTORY "${SPHINX_DIR}/build")
endif()
