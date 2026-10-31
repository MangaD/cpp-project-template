# Inherit the upstream LLVM Release configuration and use the static MSVC CRT (/MT).
include("${CMAKE_CURRENT_LIST_DIR}/x64-win-llvm-static-md-release.cmake")

set(VCPKG_CRT_LINKAGE static)