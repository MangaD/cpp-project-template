# Inspired by:
# - https://github.com/QianYizhou/gtest-cmake-gcov-example/blob/master/cmake/CodeCoverage.cmake
# - https://stackoverflow.com/a/11437693/3049315
# - https://github.com/shenxianpeng/gcov-example/
# - https://clehaxze.tw/gemlog/2022/06-28-coverage-testing-with-cmake-and-gcov.gmi
# - https://github.com/shenxianpeng/gcov-example/blob/master/makefile
# Other example considered but not used:
# - https://stackoverflow.com/a/16536401/3049315

if (NOT CMAKE_BUILD_TYPE STREQUAL "Coverage")
	message(FATAL_ERROR "Must set CMAKE_BUILD_TYPE to \"Coverage\" in order to generate code coverage results.")
endif()

if(MSVC)
	# Integrate OpenCppCoverage with CTest:
	# - https://github.com/OpenCppCoverage/OpenCppCoverage/issues/85
	# - https://github.com/boostorg/nowide/blob/84f074c2159a3c75f43120a5405e13a95cc5e639/cmake/FindOpenCppCoverage.cmake
	# Use --excluded_line_regex because: https://github.com/OpenCppCoverage/OpenCppCoverage/issues/121

	find_program(OpenCppCoverage_PATH OpenCppCoverage.exe)

	if(OpenCppCoverage_PATH)
	
		message(STATUS "Found OpenCppCoverage: ${OpenCppCoverage_PATH}")

		# List source arguments
		file(GLOB_RECURSE SRC_FILES LIST_DIRECTORIES false RELATIVE ${CMAKE_SOURCE_DIR} "*.[ch]pp")
		set(sourceArgs "")
		foreach(srcFile ${SRC_FILES})
			get_filename_component(srcFile ${srcFile} NAME)
			set(sourceArgs "${sourceArgs} --sources ${srcFile} ")
		endforeach()
		get_filename_component(OpenCppCoverage_PATH ${OpenCppCoverage_PATH} NAME)

		# Output file name
		get_property(counter GLOBAL PROPERTY OpenCppCoverage_COUNTER)
		if(NOT counter)
			set(counter 1)
		else()
			math(EXPR counter "${counter} + 1")
		endif()
		set_property(GLOBAL PROPERTY OpenCppCoverage_COUNTER "${counter}")
		set(outputFile ${CMAKE_CURRENT_BINARY_DIR}/OpenCppCoverage/cov-${counter}-coverage)

		add_custom_command(OUTPUT ${outputFile}
			DEPENDS coverage
			COMMAND ${OpenCppCoverage_PATH}
				--working_dir ${CMAKE_CURRENT_BINARY_DIR}
				--export_type html:${outputFile}
				--cover_children
				#--excluded_line_regex "\\s*\\}.*"
				-- ${CMAKE_CTEST_COMMAND} -C Debug
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			VERBATIM
			COMMENT "Running OpenCppCoverage to produce HTML coverage report."
		)
		add_custom_target(coverage DEPENDS ${outputFile})
	
	endif()
	
elseif(CMAKE_COMPILER_IS_GNUCXX OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")

	# The --coverage flag is a synonym for -fprofile-arcs -ftest-coverage (when compiling) 
	# and -lgcov (when linking)
	set(CMAKE_CXX_FLAGS_COVERAGE "-g -O0 --coverage")
	set(CMAKE_C_FLAGS_COVERAGE "-g -O0 --coverage")
	set(CMAKE_EXE_LINKER_FLAGS_COVERAGE "--coverage")
	set(CMAKE_SHARED_LINKER_FLAGS_COVERAGE "--coverage")

	mark_as_advanced(
		CMAKE_CXX_FLAGS_COVERAGE
		CMAKE_C_FLAGS_COVERAGE
		CMAKE_EXE_LINKER_FLAGS_COVERAGE
		CMAKE_SHARED_LINKER_FLAGS_COVERAGE )

	find_program(GCOV_PATH gcov)
	find_program(LCOV_PATH lcov)
	find_program(GENHTML_PATH genhtml)
	find_program(GCOVR_PATH gcovr)

	if(NOT GCOV_PATH)
		message(FATAL_ERROR "gcov not found!")
	else()
		message(STATUS "Found gcov: ${GCOV_PATH}")
	endif()

	if(LCOV_PATH)
		message(STATUS "Found lcov: ${LCOV_PATH}")
	endif()

	if(GENHTML_PATH)
		message(STATUS "Found genhtml: ${GENHTML_PATH}")
	endif()

	if(LCOV_PATH AND GENHTML_PATH)
		# Setup targets
		add_custom_target(lcov
			
			# Cleanup lcov
			${LCOV_PATH} --directory . --zerocounters
			
			# Run tests
			COMMAND ${CMAKE_CTEST_COMMAND}

			COMMAND mkdir -p coverage
			
			# Capturing lcov counters and generating report
			COMMAND ${LCOV_PATH} --directory . --capture --output-file coverage/lcov.info --rc lcov_branch_coverage=1
			COMMAND ${LCOV_PATH} --remove coverage/lcov.info 'build/*' 'tests/*' '/usr/*' --output-file coverage/lcov.info.cleaned
			COMMAND mv coverage/lcov.info.cleaned coverage/lcov.info
			
			WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
			COMMENT "Running lcov to produce info file."
		)
		# Show info where to find the report
		add_custom_command(TARGET lcov POST_BUILD
			COMMAND ;
			COMMENT "lcov info file saved to ./coverage/lcov.info."
		)
		message(STATUS "-- lcov info coverage report enabled through 'lcov' target.")
		set(_outputname lcov_html)
		add_custom_target(lcov_html
			
			# Cleanup lcov
			${LCOV_PATH} --directory . --zerocounters
			
			# Run tests
			COMMAND ${CMAKE_CTEST_COMMAND}
			
			# Capturing lcov counters and generating report
			COMMAND ${LCOV_PATH} --directory . --capture --output-file ${_outputname}.info --rc lcov_branch_coverage=1
			COMMAND ${LCOV_PATH} --remove ${_outputname}.info 'build/*' 'tests/*' '/usr/*' --output-file ${_outputname}.info.cleaned
			COMMAND ${GENHTML_PATH} -o ${_outputname} ${_outputname}.info.cleaned
			COMMAND ${CMAKE_COMMAND} -E remove ${_outputname}.info ${_outputname}.info.cleaned
			
			WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
			COMMENT "Running lcov to produce HTML coverage report."
		)
		# Show info where to find the report
		add_custom_command(TARGET lcov_html POST_BUILD
			COMMAND ;
			COMMENT "Open ./${_outputname}/index.html in your browser to view the coverage report."
		)
		message(STATUS "-- lcov HTML coverage report enabled through 'lcov_html' target.")
	endif()

	if(GCOVR_PATH)
		message(STATUS "Found gcovr: ${GCOVR_PATH}")

		set(_outputname gcovr_html)
		add_custom_target(gcovr_html
			# Run tests
			COMMAND ${CMAKE_CTEST_COMMAND}
			# Create output directory
			COMMAND mkdir -p ${_outputname}
			# Run gcovr
			COMMAND ${GCOVR_PATH} --html --html-details -r ${CMAKE_SOURCE_DIR} -o ${_outputname}/index.html
			WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
			COMMENT "Running gcovr to produce HTML coverage report."
		)
		# Show info where to find the report
		add_custom_command(TARGET gcovr_html POST_BUILD
			COMMAND ;
			COMMENT "HTML coverage report saved in ${_outputname}/index.html."
		)
		message(STATUS "-- gcovr HTML coverage report enabled through 'gcovr_html' target.")
	endif()

else()
	message(STATUS "Coverage not supported with the current compiler.")
endif()

