# Installation Guide

- Setup
  - Linux
    - [Arch Linux / Manjaro Linux](#arch-linux--manjaro-linux)
    - [Debian / Linux Mint / Ubuntu](#debian--linux-mint--ubuntu)
  - [Windows](#windows)
    - [MSVC](#msvc)
    - [MinGW](mingw)
    - [Dependencies](#dependencies)
      - [vcpkg](vcpkg)
- [Compile](#compile)
  - [Linux & Mac](#linux--mac)
  - [Windows](#windows-compile)
  - [Sanitizer builds](#sanitizer-builds)
- [Package](#package)
  - [Archive](#archive)
  - [NSIS on Windows](#nsis-on-windows)
  - [DEB on Ubuntu](#deb-on-ubuntu)
- [Documentation](#documentation)

## Arch Linux / Manjaro Linux

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


## Debian / Linux Mint / Ubuntu

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

## Windows

### MSVC

Download and install [Visual Studio](https://www.visualstudio.com/).

In Visual Studio Installer, click "Modify" and install "Desktop development with C++".

### MinGW

1. Download latest [MinGW](http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/installer/)
2. Install MinGW
   *   Architecture: i686 - for compiling 32 bit programs
   *   Architecture: x86_64 - for compiling 64 bit programs
   * Threads: posix
3. Copy `mingw32-make.exe` and rename the copy to `make.exe`
4. Put the MinGW bin folder in the path

### Dependencies

- [git](https://git-scm.com/)
- CMake: Get the Windows installer at https://cmake.org/download/
- Doxygen: Get the binary distribution for Windows at https://www.doxygen.nl/download.html
- Sphinx:
  - Get Python at the Windows Store
  - `pip install sphinx`
  - `pip install breathe`
  - `pip install sphinx_rtd_theme`
- cppcheck:
  - Download at https://cppcheck.sourceforge.io/
  - Add `C:\Program Files\Cppcheck` to the Path environment variable
- LLVM (includes clang-tidy and clang-format): Get installer for Windows at https://releases.llvm.org/download.html (tick option to add to PATH during installation)
- [NSIS](https://nsis.sourceforge.io/Download)

**wxWidgets** (manual method):

Download wxWidgets installer from [https://www.wxwidgets.org/](https://www.wxwidgets.org/) and install it. Compile and install wxWidgets:

```bat
cd C:\wxWidgets-X.Y.Z\build
cmake .. -DCMAKE_INSTALL_PREFIX=C:/wxwidgets-build -DwxBUILD_SHARED=OFF
cmake --build . --target install
```

Set environment variable `wxWidgets_ROOT_DIR` to `C:/wxwidgets-build`.

Alternatively to the environment variable, compile the project with:

```sh
mkdir build
cd build
# https://stackoverflow.com/a/48947121/3049315
cmake -DwxWidgets_ROOT_DIR:PATH=C:/wxwidgets-build ..
cmake --build .
```

Detailed instructions at [wxWidgets CMake Overview](https://docs.wxwidgets.org/trunk/overview_cmake.html)

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
.\vcpkg.exe install wxwidgets:x64-windows
.\vcpkg.exe install wxwidgets:x64-windows-release
.\vcpkg.exe install wxwidgets:x64-windows-static
## For MinGW
.\vcpkg.exe install wxwidgets:x64-mingw-static

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
cmake .. -DCMAKE_TOOLCHAIN_FILE=<project_root>/vcpkg/scripts/buildsystems/vcpkg.cmake -DVCPKG_TARGET_TRIPLET=x64-windows

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

### NSIS on Windows

Download and Install the Null Soft Installer (NSIS) from [here](https://nsis.sourceforge.io/Download).

```sh
cmake ..
cmake --build . --config Release
cpack -G NSIS
```

### WiX on Windows

Download and Install the WiX Toolset from [here](https://wixtoolset.org/)

```sh
cmake ..
cmake --build . --config Release
cpack -G WIX
```

### DEB on Ubuntu

```sh
cmake ..
cpack -G DEB
```

## Documentation

```sh
# Doxygen:
cmake --build . --target doxygen
# Sphinx:
cmake --build . --target sphinx
```