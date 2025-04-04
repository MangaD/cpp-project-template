<div align="center">

# C++ Project Template

<!--
Cannot use relative path here because of the following Doxygen issue:
https://github.com/doxygen/doxygen/issues/6783#issuecomment-1058486600
-->
<img alt="cpplogo" src="https://github.com/MangaD/cpp-project-template/blob/main/docs/doxygen/logo.png?raw=true" width="150" />
<br/><br/>


<table align="center">
  <tr>
    <th>GitHub Actions</th>
    <td>

<!-- https://dev.to/azure/github-how-to-display-the-status-badge-for-a-github-action-5449 -->
[![GH Release](https://github.com/MangaD/cpp-project-template/actions/workflows/build-release.yml/badge.svg)](https://github.com/MangaD/cpp-project-template/actions/workflows/build-release.yml) [![GH Debug](https://github.com/MangaD/cpp-project-template/actions/workflows/build-debug.yml/badge.svg)](https://github.com/MangaD/cpp-project-template/actions/workflows/build-debug.yml) [![GH Doxygen](https://github.com/MangaD/cpp-project-template/actions/workflows/doxygen-gh-pages.yml/badge.svg)](https://github.com/MangaD/cpp-project-template/actions/workflows/doxygen-gh-pages.yml)

[![CDash](https://img.shields.io/badge/CDash-dashboard-green)](https://my.cdash.org/index.php?project=cpp-project-template) [![codecov](https://codecov.io/gh/MangaD/cpp-project-template/branch/main/graph/badge.svg?token=4D88K24BF0)](https://codecov.io/gh/MangaD/cpp-project-template) [![Coverage Status](https://coveralls.io/repos/github/MangaD/cpp-project-template/badge.svg?branch=main)](https://coveralls.io/github/MangaD/cpp-project-template?branch=main) <a href="https://scan.coverity.com/projects/mangad-cpp-project-template"><img alt="Coverity Scan Build Status" src="https://scan.coverity.com/projects/28433/badge.svg"/></a>

[![GitHub Latest Release](https://img.shields.io/github/downloads-pre/MangaD/cpp-project-template/latest/total)](https://github.com/MangaD/cpp-project-template/releases/latest)
    </td>
  </tr>
  <tr>
    <th>GitLab CI/CD</th>
    <td>

[![pipeline status](https://gitlab.com/MangaD/cpp-project-template/badges/main/pipeline.svg)](https://gitlab.com/MangaD/cpp-project-template/-/commits/main) [![coverage report](https://gitlab.com/MangaD/cpp-project-template/badges/main/coverage.svg)](https://gitlab.com/MangaD/cpp-project-template/-/commits/main) [![Latest Release](https://gitlab.com/MangaD/cpp-project-template/-/badges/release.svg)](https://gitlab.com/MangaD/cpp-project-template/-/releases)
    </td>
  </tr>
</table>

</div>

## About

A template for modern C++ cross-platform projects. Using CMake, CI/CD, unit tests, code coverage, static and dynamic analisis, auto formatting, package management, documentation, GUI, installers, and more. 

### Progress status

![CMake](https://img.shields.io/badge/CMake-done-green) ![CTest](https://img.shields.io/badge/CTest-done-green) ![CPack](https://img.shields.io/badge/CPack-done-green)![CDash](https://img.shields.io/badge/CDash-done-green) ![codecov](https://img.shields.io/badge/codecov-done-green) ![coveralls](https://img.shields.io/badge/coveralls-done-green) ![coverity](https://img.shields.io/badge/coverity-done-green) ![consoleApp](https://img.shields.io/badge/console%20app-done-green) ![staticLib](https://img.shields.io/badge/static%20library-done-green) ![dynamicLib](https://img.shields.io/badge/dynamic%20library-todo-red) ![wxWidgets](https://img.shields.io/badge/wxWidgets-done-green) ![Qt](https://img.shields.io/badge/Qt-todo-red) ![windowsIco](https://img.shields.io/badge/windows%20icon-done-green)
![windowsVer](https://img.shields.io/badge/windows%20version-done-green) ![i18nL10n](https://img.shields.io/badge/i18n%20and%20L10n-todo-red) ![Boost](https://img.shields.io/badge/boost-todo-red) ![GoogleTest](https://img.shields.io/badge/GoogleTest-done-green) ![BoostTest](https://img.shields.io/badge/Boost.Test-todo-red) ![Catch2](https://img.shields.io/badge/catch2-todo-red) ![Doctest](https://img.shields.io/badge/doctest-todo-red) ![vcpkg](https://img.shields.io/badge/vcpkg-done-green) ![conan](https://img.shields.io/badge/conan%202-todo-red) ![cppcheck](https://img.shields.io/badge/cppcheck-done-green) ![CSA](https://img.shields.io/badge/clang%20static%20analyzer-done-green) ![clangtidy](https://img.shields.io/badge/clang%20tidy-done-green) ![lcov](https://img.shields.io/badge/lcov-done-green) ![llvm-cov](https://img.shields.io/badge/llvm--cov-todo-red) ![gcovr](https://img.shields.io/badge/gcovr-done-green) ![OpenCppCoverage](https://img.shields.io/badge/OpenCppCoverage-needs%20work-yellow) ![valgrind](https://img.shields.io/badge/valgrind-done-green) ![sanitizers](https://img.shields.io/badge/sanitizers-done-green) ![gdb](https://img.shields.io/badge/gdb-todo-red) ![gprof](https://img.shields.io/badge/gprof-todo-red) ![IntelVTuneProfiler](https://img.shields.io/badge/Intel%20VTune%20Profiler-todo-red) ![perf](https://img.shields.io/badge/perf-todo-red) ![doxygen](https://img.shields.io/badge/doxygen-done-green) ![sphinx](https://img.shields.io/badge/sphinx-needs%20work-yellow) ![Read The Docs](https://img.shields.io/badge/Read%20the%20Docs-todo-red) ![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-done-green) ![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-done-green) ![GitLab CI/CD](https://img.shields.io/badge/GitLab%20CI/CD-todo-red) ![GitLab Pages](https://img.shields.io/badge/GitLab%20Pages-done-green) ![nsis](https://img.shields.io/badge/nsis-done-green) ![wix toolset](https://img.shields.io/badge/wix%20toolset-done-green) ![deb](https://img.shields.io/badge/deb-done-green) ![rpm](https://img.shields.io/badge/rpm-done-green) ![DragNDrop](https://img.shields.io/badge/DragNDrop-needs%20work-yellow) ![productbuild](https://img.shields.io/badge/productbuild-todo-red) ![raspbian](https://img.shields.io/badge/raspbian-todo-red) ![SignTool](https://img.shields.io/badge/SignTool-todo-red) ![GitHub Codespaces](https://img.shields.io/badge/GitHub%20Codespaces-done-green) ![MSVC](https://img.shields.io/badge/MSVC-done-green) ![MinGW](https://img.shields.io/badge/MinGW-done-green) ![LLVM](https://img.shields.io/badge/LLVM-done-green)


## Download

For downloading the app, see [latest release at GitHub](https://github.com/MangaD/cpp-project-template/releases/latest).

## Getting Started

See [getting started](./docs/getting_started.md).

## Developer Install

See [installation guide](./docs/install.md).

## Developer Guide

See [development guide](./docs/development_guide.md).

## License

See [LICENSE](./LICENSE).

The Standard C++ Foundation stylized "C++" logo has its own [license](https://isocpp.org/home/terms-of-use).

### Third-Party Libraries

This project makes use of third-party libraries, whose licenses must be taken into consideration when releasing a binary.

| Library Name | License | Authors/Notes |
|-|-|-|
| [wxWidgets](https://www.wxwidgets.org) | [wxWindows Library Licence](https://www.wxwidgets.org/about/licence/) | [The wxWidgets Team](https://www.wxwidgets.org/about/team/) | 
