# Installation Guide

- Setup
  - Linux
    - [Arch Linux / Manjaro Linux](#arch-linux--manjaro-linux)
    - [Debian / Linux Mint / Ubuntu](#debian--linux-mint--ubuntu)
    - [RedHat / Fedora / CentOS](#redhat--fedora--centos)
  - [Windows](#windows)
    - [MSVC](#msvc)
    - [MinGW](#mingw)
    - [Dependencies](#dependencies)
      - [vcpkg](#vcpkg)
  - [macOS](#macos)
- [Compile](#compile)
  - [Linux & Mac](#linux--mac)
  - [Windows](#windows-compile)
- [Package](#package)
  - [Archive](#archive)
  - Windows
    - [NSIS](#NSIS)
    - [WiX](#WiX)
  - Ubuntu
    - [DEB](#deb)
    - [RPM](#rpm)
  - MacOS
    - [DMG](#dmg)
- [Documentation](#documentation)

## Linux

### Arch Linux / Manjaro Linux

Build tools:

```sh
sudo pacman -Sy git gcc clang llvm cmake make ninja 
```

wxWidgets:

```sh
sudo pacman -Sy wxgtk3
```

Documentation:

```sh
sudo pacman -Sy doxygen python-sphinx python-breathe python-sphinx_rtd_theme
```

Static analysis:

```sh
sudo pacman -Sy cppcheck llvm
```

Debugging:

```sh
sudo pacman -Sy gdb lldb
```

Memory checker:

```sh
sudo pacman -Sy valgrind
```

CPack DEB:

```sh
sudo pacman -Sy dpkg
```

CPack RPM:

```sh
sudo pacman -Sy rpm-tools
```

GoogleTest:

```sh
sudo pacman -Sy gtest
```

Coverage:

```sh
sudo pacman -Sy lcov gcovr
```

### Debian / Linux Mint / Ubuntu

Build tools:

```sh
sudo apt install git cmake make ninja-build build-essential clang llvm
```

wxWidgets:

```sh
sudo apt install libwxgtk3.0-gtk3-dev
```

Documentation:

```sh
sudo apt install doxygen sphinx-common python3-breathe python3-sphinx-rtd-theme 
```

Static analysis:

```sh
sudo apt install cppcheck clang-tidy
```

Formatting:

```sh
sudo apt install clang-format
```

Debugging:

```sh
sudo apt install gdb lldb
```

Memory checker:

```sh
sudo apt install valgrind
```

CPack DEB:

```sh
sudo apt install dpkg
```

CPack RPM:

```sh
sudo apt install rpm
```

GoogleTest:

```sh
sudo apt install libgtest-dev
```

Coverage:

```sh
sudo apt install lcov gcovr
```

### RedHat / Fedora / CentOS

Build tools:

```sh
sudo yum -y install git cmake make ninja-build gcc gcc-c++ clang llvm
```

wxWidgets:

```sh
sudo yum -y install wxBase3 wxGTK3 wxGTK-devel
```

Documentation:

```sh
sudo yum -y install doxygen sphinx python3-breathe python3-sphinx_rtd_theme
```

Static analysis & Formatting:

```sh
sudo yum -y install cppcheck clang-tools-extra
```

Debugging:

```sh
sudo yum -y install gdb lldb
```

Memory checker:

```sh
sudo yum -y install valgrind
```

CPack DEB:

```sh
sudo yum -y install dpkg
```

CPack RPM:

```sh
sudo yum -y install rpm-build
```

GoogleTest:

```sh
sudo yum -y install gtest
```

Coverage:

```sh
sudo yum -y install lcov gcovr
```

## Windows

### MSVC

Download and install [Visual Studio](https://www.visualstudio.com/).

In Visual Studio Installer, click "Modify" and install "Desktop development with C++".

### MinGW

Download latest [MinGW builds](https://github.com/niXman/mingw-builds-binaries/releases/).

Example:
- [Architecture: i686](https://github.com/niXman/mingw-builds-binaries/releases/download/12.2.0-rt_v10-rev2/i686-12.2.0-release-posix-dwarf-msvcrt-rt_v10-rev2.7z) - for compiling 32 bit programs
- [Architecture: x86_64](https://github.com/niXman/mingw-builds-binaries/releases/download/12.2.0-rt_v10-rev2/x86_64-12.2.0-release-posix-seh-msvcrt-rt_v10-rev2.7z) - for compiling 64 bit programs

Put the MinGW bin folder in the path for the intended architecture.

### Dependencies

- [git](https://git-scm.com/)
- [CMake](https://cmake.org/download/)
- [Doxygen](https://www.doxygen.nl/download.html)
- Sphinx:
  - Get Python at the Windows Store
  - `pip install sphinx`
  - `pip install breathe`
  - `pip install sphinx_rtd_theme`
- [cppcheck](https://cppcheck.sourceforge.io/)
  - Add `C:\Program Files\Cppcheck` to the Path environment variable
- [LLVM](https://releases.llvm.org/download.html) (includes clang-tidy and clang-format). Tick option to add to PATH during installation.
- [OpenCppCoverage](https://github.com/OpenCppCoverage/OpenCppCoverage/releases/latest)
- [NSIS](https://nsis.sourceforge.io/Download)
- [WiX Toolset](https://wixtoolset.org/)

#### wxWidgets

1. Download Windows binaries from: https://www.wxwidgets.org/downloads

We need the **Header Files**, the **Development Files**, and the **Release DLLs** for the chosen compiler and architecture.

After extracting the files to a directory (e.g. C:\wxwidgets), we should end up with a file tree like this:

```
C:\wxwidgets
├───build
│   └───msw
├───include
│   ├───msvc
│   │   └───wx
│   └───wx
│       ├───android
│       ├───...
│       └───xrc
└───lib
    └───vc14x_x64_dll
        ├───mswu
        │   └───wx
        │       └───msw
        └───mswud
            └───wx
                └───msw
```

```sh
# https://stackoverflow.com/a/48947121/3049315
set wxWidgets_ROOT_DIR=C:\wxwidgets
set wxWidgets_LIB_DIR=C:\wxwidgets\lib\vc14x_x64_dll
cd <project_root>
mkdir build && cd build
cmake .. -DBUILD_TESTING=OFF
cmake --build . --config Release
```

Instructions at: https://docs.wxwidgets.org/stable/plat_msw_binaries.html

#### Google Test

Install Google Test:

```sh
cd C:
git clone https://github.com/google/googletest.git -b v1.13.0
cd googletest
mkdir build && cd build
cmake .. #-DBUILD_GMOCK=OFF
cmake --build . --config Debug
cmake --build . --config Release
```

```sh
cd <project_root>
# https://stackoverflow.com/a/32749652/3049315
cd <project_root>
mkdir build && cd build
cmake .. -DGTEST_ROOT:PATH="C:\googletest\googletest" -DGTEST_LIBRARY:PATH="C:\googletest\build\lib\Release\gtest.lib" -DGTEST_MAIN_LIBRARY:PATH="C:\googletest\build\lib\Release\gtest_main.lib" #-DBUILD_PROJECTWX=OFF
cmake --build . --config Release
```

#### vcpkg

```sh
cd <project_root>

# Install vcpkg - A C++ package manager
# https://docs.microsoft.com/en-us/cpp/build/vcpkg?view=vs-2019
# https://devblogs.microsoft.com/cppblog/vcpkg-updates-static-linking-is-now-available/
git clone https://github.com/Microsoft/vcpkg
cd .\vcpkg
.\bootstrap-vcpkg.bat

# Search library example (optional, just to see if it's available)
.\vcpkg.exe search zlib

## Install libraries (x86 for 32-bit, x64 for 64-bit)
# wxWidgets with vcpkg: https://www.wxwidgets.org/blog/2019/01/wxwidgets-and-vcpkg/
#.\vcpkg.exe install wxwidgets:x86-windows
#.\vcpkg.exe install wxwidgets:x64-windows
#.\vcpkg.exe install wxwidgets:x64-windows-release
.\vcpkg.exe install wxwidgets:x64-windows-static
.\vcpkg.exe install gtest:x64-windows-static
## For MinGW
.\vcpkg.exe install wxwidgets:x64-mingw-static
.\vcpkg.exe install gtest:x64-mingw-static

# Make libraries available
.\vcpkg.exe integrate install

# Build project
cd ..
mkdir build && cd build
# toolchain file must have full path
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_TOOLCHAIN_FILE=<project_root>/vcpkg/scripts/buildsystems/vcpkg.cmake -DVCPKG_TARGET_TRIPLET=x64-windows-static -DVCPKG_HOST_TRIPLET=x64-windows-static
# -DVCPKG_TARGET_TRIPLET=x64-mingw-static -DVCPKG_HOST_TRIPLET=x64-mingw-static
#-DVCPKG_TARGET_TRIPLET=x64-windows-release
#-DVCPKG_TARGET_TRIPLET=x64-windows

# If your generator is a single-config generator like "Unix Makefiles" or "Ninja", then the build type is specified by the CMAKE_BUILD_TYPE variable, which can be set in the configure command by using -DCMAKE_BUILD_TYPE:STRING=Release. For multi-config generators like the Visual Studio generators and "Ninja Multi-Config", the config to build is specified in the build command using the --config argument argument like --config Release. A default value can be specified at configure time by setting the value of the CMAKE_DEFAULT_BUILD_TYPE variable, which will be used if the --config argument isn't passed to the build command.
# https://stackoverflow.com/a/74077157/3049315
cmake --build . --config Release
```

## macOS

```sh
brew install wxwidgets googletest
```

## Compile

Tip: Use Ninja. It can run faster, is less noisy, defaults to multiple cores, and can use the same directory for debug and release builds.

```sh
cmake .. -G "Ninja Multi-Config"
ninja
```

Building for release:

```sh
cmake --build . --config Release
```

Clean:

```sh
cmake --build . --target clean
```

Reference: https://cmake.org/cmake/help/v3.22/guide/user-interaction/index.html#invoking-the-buildsystem

### Linux & Mac

```sh
git clone --recursive -j4 https://github.com/MangaD/cpp-project-template
cd cpp-project-template
mkdir build && cd build
cmake .. -G "Ninja"
ninja
```

<a id="windows-compile"></a>
### Windows

```bat
git clone --recursive -j4 https://github.com/MangaD/cpp-project-template
cd cpp-project-template
mkdir build && cd build

# without vcpkg:
cmake ..
# with vcpkg:
cmake .. -DCMAKE_TOOLCHAIN_FILE=<project_root>/vcpkg/scripts/buildsystems/vcpkg.cmake -DVCPKG_TARGET_TRIPLET=x64-windows-static -DVCPKG_HOST_TRIPLET=x64-windows-static

cmake --build . --config Release
```

## Package

### Archive

**Package the binary:**
```sh
# following is necessary with MSVC:
cmake --build . --config Release
cpack
# or, on linux:
make package
```

**Package the source code:**
```sh
cpack --config CPackSourceConfig.cmake
# or, on linux:
make package_source
```

### Windows

#### NSIS

Download and Install the Null Soft Installer (NSIS) from [here](https://nsis.sourceforge.io/Download).

```sh
cmake ..
cmake --build . --config Release
cpack -G NSIS64
```

#### WiX

Download and Install the WiX Toolset from [here](https://wixtoolset.org/)

```sh
cmake ..
cmake --build . --config Release
cpack -G WIX
```

### Ubuntu

#### DEB

```sh
cmake ..
cpack -G DEB
```

#### RPM

```sh
cmake ..
cpack -G RPM
```

### MacOS

#### DMG

```sh
cmake ..
cpack -G DragNDrop
```

## Documentation

```sh
# Doxygen:
cmake --build . --target doxygen
# Sphinx:
cmake --build . --target sphinx
```