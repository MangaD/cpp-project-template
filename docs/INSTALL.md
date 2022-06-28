# Installation Guide

- Installation
  - Linux
    - [Arch Linux / Manjaro Linux](#arch-linux--manjaro-linux)
  - [Windows](#windows)

## Arch Linux / Manjaro Linux

Install dependencies:

```sh
sudo pacman -Syu gcc clang llvm cmake gdb lldb make ninja git valgrind cppcheck doxygen python-sphinx python-breathe python-sphinx_rtd_theme
```

Get `cpp-project-template` source, compile and install:

```sh
git clone --recursive https://github.com/MangaD/cpp-project-template
cd cpp-project-template
mkdir build && cd build
cmake .. -G "Ninja"
make
sudo make install
```

## Windows

- git: https://git-scm.com/
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