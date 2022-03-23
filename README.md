# C++ Project Template

![CMake Matrix](https://github.com/MangaD/cpp-project-template/actions/workflows/cmake.yml/badge.svg) ![Doxygen](https://github.com/MangaD/cpp-project-template/actions/workflows/doxygen-gh-pages.yml/badge.svg)

## About



## Installation

See [installation guide](docs/INSTALL.md).

## Formatting, linting, and static analysis

### Format the source code with `clang-format`

Useful after renaming variables or after editing source code with an editor that does not recognise the file `.clang-format`.

```sh
make format
```

### Static analyze with `clang-tidy`

```sh
make tidy
```

### Static analyze with `cppcheck`

```sh
make cppcheck
```

## Testing

```sh
cmake --build .
ctest
```

CTest tutorial and options: https://coderefinery.github.io/cmake-workshop/testing/

### Memory check with Valgrind

```cpp
make test_memcheck
# ctest -T memcheck
```

### Sanitizer builds

To make a sanitizer build, customize `cmake/SanitizerBlacklist.txt.in` at your will then

```bash
cmake ../ -DPROJECT_BUILD_SANITIZER_TYPE=${sanitizer_type} -DCMAKE_BUILD_TYPE=Debug
```

Where `sanitizer_type` is either `address`, `memory`, `thread` or `undefined`.

## Package the application

### Generic

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

Download and Install Null Soft Installer (NSIS) from [here](https://nsis.sourceforge.io/Download).

```sh
cmake ..
cmake --build . --config Release
cpack -G NSIS
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

**Dev tips:**
1. Files are considered private by default. Having a file command will have documentation be generated for it. See: https://linux.m2osw.com/doxygen-does-not-generate-documentation-my-c-functions-or-any-global-function
2. Documenting the namespace is necessary for references to work. See: https://stackoverflow.com/q/46845369/3049315
3. The main page of doxygen is set with the `\mainpage` command. See: https://www.doxygen.nl/manual/commands.html#cmdmainpage
   But it is possible to set an MD file as the main page. See: https://stackoverflow.com/a/26244558/3049315
4. For Sphinx instructions, see:
   - https://www.sphinx-doc.org/en/master/index.html
   - https://sphinx-themes.org/sample-sites/sphinx-rtd-theme/

## TODO

- [ ] Sphinx
  - [ ] layout + organization
  - [ ] publishing with: https://readthedocs.org/ , github pages , and gitlab pages
- [ ] Catch2 or Google Test
- [ ] Code coverage (lcov, gcov) + codecov
- [ ] Review sanitizer script
- [ ] CDash
- [ ] Appveyor + Travis + GitLab CI/CD
- [ ] vcpkg or conan
- [ ] i18n and L10n
- [ ] Boost


---

Tip: Use Ninja. It can run faster, is less noisy, defaults to multiple cores, and can use the same directory for debug and release builds.

```sh
cmake .. -G "Ninja Multi-Config"
ninja
ninja cppcheck
./bin/Debug/DG
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