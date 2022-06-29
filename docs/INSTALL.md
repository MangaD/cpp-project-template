# Installation Guide

- Installation
  - Linux
    - [Arch Linux / Manjaro Linux](#arch-linux--manjaro-linux)
    - [Ubuntu](#ubuntu)
  - [Windows](#windows)

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

Get `cpp-project-template` source, compile and install:

```sh
git clone --recursive https://github.com/MangaD/cpp-project-template
cd cpp-project-template
mkdir build && cd build
cmake .. -G "Ninja"
ninja
sudo ninja install
```

## Ubuntu

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

- [Visual Studio](https://www.visualstudio.com/)
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

**wxWidgets:**

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