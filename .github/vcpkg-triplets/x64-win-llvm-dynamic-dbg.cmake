# Inherit the upstream LLVM configuration, including its dynamic MSVC CRT.
# Debug dependencies use /MDd.
include("${CMAKE_CURRENT_LIST_DIR}/x64-win-llvm.cmake")