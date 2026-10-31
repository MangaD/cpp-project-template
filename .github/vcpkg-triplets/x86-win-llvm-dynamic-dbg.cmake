# Inherit the custom LLVM Debug configuration, targeting Windows x86.
include("${CMAKE_CURRENT_LIST_DIR}/x64-win-llvm-dynamic-dbg.cmake")

set(VCPKG_TARGET_ARCHITECTURE x86)