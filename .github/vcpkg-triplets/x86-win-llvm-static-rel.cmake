# Windows x86 Release build using LLVM/ClangCL.
#
# Reuse the upstream x64 LLVM Release configuration, including its
# toolchain, linkage settings, and port-specific customizations.
# Override only the target architecture and CRT linkage.

include("${CMAKE_CURRENT_LIST_DIR}/x64-win-llvm-static-md-release.cmake")

set(VCPKG_TARGET_ARCHITECTURE x86)
set(VCPKG_CRT_LINKAGE static)