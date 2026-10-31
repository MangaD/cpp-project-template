# Reuse the custom x64 Debug triplet to keep CRT settings consistent.
include("${CMAKE_CURRENT_LIST_DIR}/x64-win-llvm-static-dbg.cmake")

# Override the target architecture for 32-bit Windows.
set(VCPKG_TARGET_ARCHITECTURE x86)