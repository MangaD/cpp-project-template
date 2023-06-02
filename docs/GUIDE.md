# Development Guide

- [Autoformatting](#autoformatting)
- [Static analysis](#static-analysis)
- [Testing](#testing)
  - [Coverage](#coverage)
  - [Dynamic analysis](#dynamic-analysis)
    - [Valgrind](#valgrind)
    - [Sanitizers](#sanitizers)
  - [CDash](#cdash)
- [CMake tips](#cmake-tips)
- [Doxygen tips](#doxygen-tips)
- [GitHub Actions tips](#github-actions-tips)
  - [Releases](#releases)
- [Adding libraries](#adding-libraries)
- [Windows XP](#windows-xp)
- [Tutorial links](#tutorial-links)

## Autoformatting

Some IDEs recognize the `.clang-format` file located in the root directory of the project and autoformat the code upon saving, according to the style and rules specified in the file. However, the clang-format tool is also integrated in the CMake script of this project, in the module `cmake/clang-format.cmake`, so it is possible to autoformat the entire source code by calling the `format` target, such as:

```sh
cmake --build . --target format
# or, if using make:
make format
```

The current script is set to format all the source files with the following extensions: `.h`, `.hpp`, `.c`, `.cpp`.

## Static analysis

With Clang Static Analyzer:

```sh
scan-build cmake .. -G "Ninja"
scan-build ninja
```

With `clang-tidy`:

```sh
# Using a CMake preset:
cmake .. --preset tidy
# Uses a CMake variable and the .clang-tidy file:
cmake .. -DCMAKE_CXX_CLANG_TIDY="clang-tidy"
# Appends globs to the 'Checks' option in the .clang-tidy file:
cmake .. -DCMAKE_CXX_CLANG_TIDY="clang-tidy;-checks=cppcore*,-cppcoreguidelines-owning-memory"

cmake --build .
```

With `cppcheck`:

```sh
# Using a CMake preset:
cmake .. --preset cppcheck
# Using a CMake variable:
cmake .. -DCMAKE_CXX_CPPCHECK="cppcheck;--enable=all;--force;--inline-suppr;--suppressions-list=../CppCheckSuppressions.txt;--library=wxwidgets"

cmake --build .
```

## Testing

Using a multi-config generator:

```sh
cd build
cmake .. -G "Ninja Multi-Config"
cmake --build . --config Debug
ctest -C Debug #-j10
ctest -C Debug -T memcheck
```

### Coverage

#### GCC / Clang

```sh
cd build
cmake .. -G "Ninja" -DCMAKE_BUILD_TYPE=Coverage
cmake --build .
ctest
ctest -T coverage
# or,
# ctest -T Test -T Coverage
```

Coverage info can be found in `cpp-project-template/build/Testing/`.

You can also use your IDE's viewer. For VSCode I found the [Gcov Viewer extension](https://marketplace.visualstudio.com/items?itemName=JacquesLucke.gcov-viewer) to be quite good. After running CTest, press Ctrl+Shift+P and type "GCov Viewer: Load" to load the report. Then press Ctrl+Shift+P and type "GCov Viewer: Show" to show the result.

**Generate lcov HTML report:**

```sh
cmake --build .
cmake --build . --target lcov_html
```

Report can be found in `cpp-project-template/build/lcov/`.

**Generate gcovr HTML report:**

After running CTest, do:

```sh
cmake --build .
cmake --build . --target gcovr_html
```

Report can be found in `cpp-project-template/build/gcovr/`.

#### MSVC

```sh
cd build
cmake .. -DCMAKE_BUILD_TYPE:STRING=Coverage -DCMAKE_TOOLCHAIN_FILE=<project_root>/vcpkg/scripts/buildsystems/vcpkg.cmake -DVCPKG_TARGET_TRIPLET=x64-windows -DVCPKG_HOST_TRIPLET=x64-windows
cmake --build . --config Debug
ctest -C Debug
cmake --build . --target projectlib_gtest_coverage
```

### Dynamic analysis

#### Valgrind

```sh
ctest -T memcheck
# or
cmake --build . --target test_memcheck
# or, if using make
make test_memcheck
```

#### Sanitizers

If using Clang, customize `SanitizerBlacklist.txt` at your will.

```sh
# Using gcc:
cmake .. -DCMAKE_CXX_FLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer"

# Using clang:
cmake .. -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer -fsanitize-blacklist=/full/path/to/SanitizerBlacklist.txt"

# Executing wxWidgets project with lsan suppressions:
ASAN_OPTIONS=detect_leaks=1 LSAN_OPTIONS=suppressions=../src/projectwx/wx_lsan_suppressions.txt ./bin/projectwx
```

More about sanitizers: 
- https://hpc-wiki.info/hpc/Compiler_Sanitizers
- https://developers.redhat.com/blog/2021/05/05/memory-error-checking-in-c-and-c-comparing-sanitizers-and-valgrind

### CDash

CDash Dashboard: https://my.cdash.org/index.php?project=cpp-project-template

```sh
cmake -S . -B build -G "Ninja" -DCMAKE_BUILD_TYPE=Coverage
cmake --build build
ctest --test-dir build -D Experimental -T Test -T Coverage -T memcheck
```

## CMake tips

1. Check the available targets with:

```sh
cmake --build . --target help
```

2. List available presets with:

```sh
cmake .. --list-presets
```

## Doxygen tips

1. Files are considered private by default. Having a file command will have documentation be generated for it. See: https://linux.m2osw.com/doxygen-does-not-generate-documentation-my-c-functions-or-any-global-function
2. Documenting the namespace is necessary for references to work. See: https://stackoverflow.com/q/46845369/3049315
3. The main page of doxygen is set with the `\mainpage` command. See: https://www.doxygen.nl/manual/commands.html#cmdmainpage
   But it is possible to set an MD file as the main page. See: https://stackoverflow.com/a/26244558/3049315

## GitHub Actions tips

1. GitHub Actions uses the [latest runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources) available and for this reason may need maintenance.
2. CI/CD scripts should be made executable, like so:
```sh
git update-index --chmod=+x ./.github/scripts/*.cmake
```

### Releases

A release is created when creating and pushing a tag that starts with `v`.

## Adding libraries

Adding libraries to the project requires modifying the `vcpkg.json` file, the CI/CD workflow files, the `docs/INSTALL.md` file, and the `CMakeLists.txt` file of the project that you are adding the library to..

## Windows XP

For MSVC see [here](https://learn.microsoft.com/en-us/cpp/build/configuring-programs-for-windows-xp?view=msvc-170). For MinGW see [here](https://github.com/msys2/MSYS2-packages/issues/1784).

Naturally, the Windows API has evolved since Windows XP and modern features will not work with this OS.

## Tutorial links

### CMake

- [Mastering CMake](https://cmake.org/cmake/help/book/mastering-cmake/index.html)
- [CMake Reference Documentation](https://cmake.org/cmake/help/latest/index.html)
- [CMake Presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html)
- [VS Code with CMake](https://code.visualstudio.com/docs/cpp/cmake-linux)
- [Installing & Testing](https://cmake.org/cmake/help/latest/guide/tutorial/Installing%20and%20Testing.html)
- [CTest](https://cmake.org/cmake/help/latest/module/CTest.html)
- [CTest tutorial and options](https://coderefinery.github.io/cmake-workshop/testing/)

### Testing

- [GoogleTest User's Guide](https://google.github.io/googletest/)
- [CMake GoogleTest](https://cmake.org/cmake/help/latest/module/GoogleTest.html)
- [CDash](https://cmake.org/cmake/help/book/mastering-cmake/chapter/CDash.html)

### Coverage

- [Codecov example](https://github.com/codecov/example-c)
- [GCov: How to Set Up Codecov with C and GitHub Actions](https://about.codecov.io/blog/how-to-set-up-codecov-with-c-and-github-actions/)
- [OpenCppCoverage: How to Set Up Codecov with C++ and GitHub Actions](https://about.codecov.io/blog/how-to-set-up-codecov-with-c-plus-plus-and-github-actions/)
- [coveralls and gcovr](https://github.com/marketplace/actions/gcovr-action)
- [How to use gcov](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html)
- [VSCode Gcov Viewer](https://marketplace.visualstudio.com/items?itemName=JacquesLucke.gcov-viewer)
- [OpenCppCoverage Wiki](https://github.com/OpenCppCoverage/OpenCppCoverage/wiki)

### Profiling

- [GPROF Tutorial](https://www.thegeekstuff.com/2012/08/gprof-tutorial/)

### Documentation

- For Sphinx instructions, see:
  - https://www.sphinx-doc.org/en/master/index.html
  - https://sphinx-themes.org/sample-sites/sphinx-rtd-theme

### Versioning

- [Semantic Versioning](https://semver.org/)

### Licenses

- [tl;drLegal: Software Licenses in Plain English](https://tldrlegal.com)
- [OSI Approved Licenses](https://opensource.org/licenses/)

### Signing

- [How to avoid the "Windows Defender SmartScreen prevented an unrecognized app from starting" warning](https://stackoverflow.com/a/66582477/3049315)