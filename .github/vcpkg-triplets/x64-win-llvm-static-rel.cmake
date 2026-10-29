# Reuse the upstream LLVM Release configuration with a static MSVC runtime.
include("${CMAKE_CURRENT_LIST_DIR}/x64-win-llvm-static-md-release.cmake")

set(VCPKG_CRT_LINKAGE static)