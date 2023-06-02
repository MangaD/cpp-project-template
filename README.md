# C++ Project Template

![CMake Matrix](https://github.com/MangaD/cpp-project-template/actions/workflows/cmake.yml/badge.svg) ![Doxygen](https://github.com/MangaD/cpp-project-template/actions/workflows/doxygen-gh-pages.yml/badge.svg)

## About

This repository aims to provide a modern C++ cross-platform codebase template, featuring a series of development tools integrated with CMake, a CI/CD pipeline, and wxWidgets integration.

### Features

- [x] Static library
- [ ] Dynamic library
- [x] Console app
- [x] GUI app
  - [x] wxWidgets
- [x] Windows resources
  - [x] Icon
  - [x] Version data
- [ ] i18n and L10n
- [ ] Boost
- [ ] Unit testing
  - [ ] Catch2
  - [ ] GoogleTest
- [ ] Code coverage (lcov, gcov) + codecov
- [x] CMake integration
  - [x] CTest
  - [x] CPack
  - [ ] CDash
- [x] Package manager
  - [x] vcpkg
  - [ ] conan
- [x] Static analysis
  - [x] cppcheck
  - [x] clang-tidy
- [x] Dynamic analysis
  - [x] valgrind
- [x] Sanitizers (gcc & clang)
- [ ] Profiling (https://hackingcpp.com/cpp/tools/profilers.html)
  - [ ] GNU Profiler (gprof)
  - [ ] Intel VTune Profiler
  - [ ] perf

- [x] Documentation
  - [x] Doxygen
    - [x] GitHub Pages
  - [x] Sphinx
    - [ ] layout + organization
    - [ ] publishing with: https://readthedocs.org/ , github pages , and gitlab pages
- [x] CI/CD
  - [x] GitHub Actions
    - [x] Windows Latest MSVC
      - [x] Archive
      - [ ] NSIS installer
    - [x] Windows Latest MinGW
      - [x] Archive
      - [ ] NSIS installer
    - [x] Ubuntu Latest GCC
      - [x] Archive
      - [ ] DEB
    - [x] macOS Latest Clang
    - [ ] Raspbian
      - [ ] [arm-runner](https://github.com/marketplace/actions/arm-runner)
      - [ ] [Install wxWidgets on RPI](https://yasriady.blogspot.com/2015/10/how-to-build-wxwidgets-for-raspberry-pi.html)
  - [ ] GitLab CI/CD
  - [ ] Travis CI
  - [ ] Appveyor

## Installation

See [installation guide](docs/INSTALL.md).

## Guide

See [development guide](docs/GUIDE.md).

## License

See [LICENSE](LICENSE).

Popular software licenses summarized: https://tldrlegal.com
