# Inherit the upstream LLVM x64 triplet, including its toolchain settings.
include("${CMAKE_CURRENT_LIST_DIR}/x64-win-llvm.cmake")

# Use the static MSVC CRT (/MTd in Debug) to match the project's targets.
set(VCPKG_CRT_LINKAGE static)