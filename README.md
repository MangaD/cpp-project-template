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
ctest -C Debug
```

CTest tutorial and options: https://coderefinery.github.io/cmake-workshop/testing/

### Memory check with Valgrind

```cpp
make test_memcheck
# ctest -T memcheck
```

**Documentation tips:**
1. Files are considered private by default. Having a file command will have documentation be generated for it. See: https://linux.m2osw.com/doxygen-does-not-generate-documentation-my-c-functions-or-any-global-function
2. Documenting the namespace is necessary for references to work. See: https://stackoverflow.com/q/46845369/3049315
3. The main page of doxygen is set with the `\mainpage` command. See: https://www.doxygen.nl/manual/commands.html#cmdmainpage
   But it is possible to set an MD file as the main page. See: https://stackoverflow.com/a/26244558/3049315
4. For Sphinx instructions, see:
   - https://www.sphinx-doc.org/en/master/index.html
   - https://sphinx-themes.org/sample-sites/sphinx-rtd-theme/
5. GitHub Actions uses the [latest runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources) available and for this reason may need maintenance.

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
- [ ] GitHub Actions make installers with CPack
- [ ] GitHub Actions ARM processor
- [ ] Dynamic library

