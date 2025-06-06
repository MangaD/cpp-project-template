### TODO

- [ ] Improve versioning: https://gist.github.com/MangaD/ab03ab98c8f7cc804149a6f2500847e5
- [x] Static library
- [ ] Dynamic library
- [x] Console app
- [x] GUI app
  - [x] wxWidgets
    - [ ] Change log in About menu item.
  - [ ] Qt (see:
      - https://doc.qt.io/qt-6/cmake-get-started.html#building-a-c-gui-application
      - https://code.qt.io/cgit/qt-creator/qt-creator.git/plain/share/qtcreator/templates/wizards/qtcreatorplugin/github_workflows_build_cmake.yml)
- [x] Windows resources
  - [x] Icon
  - [x] Version data
  - [ ] Manifest
- [ ] i18n and L10n
- [ ] Boost
- [ ] Unit testing
  - [x] GoogleTest
  - [ ] Boost.Test
  - [ ] Catch2 + [wxWidgets testing](https://github.com/wxWidgets/wxWidgets/blob/master/docs/contributing/how-to-write-unit-tests.md)
  - [ ] Doctest
- [ ] Code coverage
  - [x] gcov + lcov + genhtml
  - [x] codecov
  - [x] coveralls
  - [x] coverity
  - [ ] OpenCppCoverage
  - [ ] llvm-cov
- [x] CMake integration
  - [x] CTest
  - [x] CPack
    - [ ] Sign the executables (see: https://stackoverflow.com/a/252245/3049315)
  - [x] CDash
  - [ ] [cmake-format](https://github.com/cheshirekow/cmake_format)
- [x] Package manager
  - [x] vcpkg
  - [ ] conan 2
- [x] Static analysis
  - [x] Clang Static Analyzer
  - [x] cppcheck
  - [x] clang-tidy
- [x] Dynamic analysis
  - [x] valgrind
- [x] Sanitizers (gcc & clang)
- [ ] Profiling (https://hackingcpp.com/cpp/tools/profilers.html)
  - [ ] GNU Profiler (gprof)
  - [ ] Intel VTune Profiler
  - [ ] perf + [hotspot](https://github.com/KDAB/hotspot)
- [ ] Benchmarking
  - [ ] Google Benchmark
- [x] Documentation
  - [x] Doxygen
    - [ ] TOC
    - [x] GitHub corner
    - [ ] GitLab Pages
    - [x] GitHub Pages
  - [x] Sphinx
    - [ ] layout + organization (inspiration: https://discordpy.readthedocs.io)
    - [ ] publishing with: https://readthedocs.org/ , github pages , and gitlab pages
  - [ ] Coverage report
- [x] CI/CD
  - [x] GitHub Actions
    - [ ] clang-format
    - [ ] cppcheck
    - [ ] clang-tidy
    - [ ] Clang Static Analyzer
    - [x] CDash
    - [x] codecov
    - [x] coveralls
    - [x] coverity
    - [x] Windows Latest MSVC
      - [x] 32-bit
      - [x] 64-bit
      - [x] Archive
      - [x] NSIS installer
      - [x] WiX Toolset
    - [x] Windows Latest MinGW
      - [x] 32-bit
      - [x] 64-bit
      - [x] Archive
      - [x] NSIS installer
      - [x] WiX Toolset
    - [ ] Windows Latest Clang
      - [ ] 32-bit
      - [x] 64-bit
      - [x] Archive
      - [x] NSIS installer
      - [x] WiX Toolset
    - [x] Ubuntu Latest GCC
      - [x] Archive
      - [x] DEB
      - [x] RPM
    - [x] macOS Latest Clang
      - [ ] DragNDrop
      - [ ] productbuild
    - [ ] Raspbian
      - [ ] [Cross compile in Ubuntu](https://stackoverflow.com/a/11123927/3049315)
      - [ ] [Cross-compiling with conan 2](https://docs.conan.io/2/tutorial/consuming_packages/cross_building_with_conan.html)
      - [ ] [arm-runner](https://github.com/marketplace/actions/arm-runner)
      - [ ] [Install wxWidgets on RPI](https://yasriady.blogspot.com/2015/10/how-to-build-wxwidgets-for-raspberry-pi.html)
      - [ ] [GH Actions self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners)
  - [ ] GitLab CI/CD (see: https://gitlab.mel.vin/template/c/-/tree/master/)
  - [ ] Travis CI
  - [ ] Appveyor
  - [ ] TeamCity
  - [ ] Azure Pipelines
  - [ ] Jenkins
  - [ ] CircleCI
  - [x] [GitHub Codespaces](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers#using-a-predefined-dev-container-configuration)
  - [ ] Docker
