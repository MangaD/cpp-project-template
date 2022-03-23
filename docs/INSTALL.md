# Installation Guide

- Installation
  - Linux
    - [Arch Linux / Manjaro Linux](#arch-linux--manjaro-linux)

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
