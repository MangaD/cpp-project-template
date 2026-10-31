# Inherit the custom LLVM Release configuration, targeting Windows x86.
include("${CMAKE_CURRENT_LIST_DIR}/x64-win-llvm-static-rel.cmake")

set(VCPKG_TARGET_ARCHITECTURE x86)