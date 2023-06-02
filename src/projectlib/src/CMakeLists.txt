file(GLOB PROJECT_LIB_FILES "*.cpp")

add_library(${PROJECT_LIB_NAME} STATIC ${PROJECT_LIB_FILES})

# Set to PUBLIC so that executables depending on this library also use these definitions
target_compile_definitions(${PROJECT_LIB_NAME} PUBLIC
	# Disable secure warnings on MSVC
	$<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS>
	$<$<PLATFORM_ID:Windows>:UNICODE _UNICODE>
)
# Note: NDEBUG is defined in the C standard, but DEBUG is not.
# Read comments: https://stackoverflow.com/a/8594122/3049315
# C standard section: http://port70.net/~nsz/c/c11/n1570.html#7.2

# Enable warnings - inspired by: https://stackoverflow.com/a/50882216/3049315
target_compile_options(${PROJECT_LIB_NAME} PUBLIC
	$<$<CXX_COMPILER_ID:MSVC>:/W4> # /WX
	$<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -pedantic -Wmain -Weffc++ -Wswitch-default
		-Wswitch-enum -Wmissing-include-dirs -Wmissing-declarations -Wunreachable-code -Winline
		-Wfloat-equal -Wundef -Wcast-align -Wredundant-decls -Winit-self -Wshadow -Wnon-virtual-dtor
		-Wconversion -Wstrict-aliasing -Wold-style-cast -Wsign-conversion>
	$<$<CXX_COMPILER_ID:GNU>:-Wzero-as-null-pointer-constant -Wsuggest-override>
	$<$<AND:$<CXX_COMPILER_ID:GNU>,$<VERSION_GREATER:$<CXX_COMPILER_VERSION>,10.1>>: -Warith-conversion>
	$<$<CXX_COMPILER_ID:Clang>:-Wthread-safety>
)
