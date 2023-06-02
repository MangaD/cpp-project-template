# Development Guide

- [Autoformatting](#autoformatting)
- [Static analysis](#static-analysis)
- [Testing](#testing)
- [Dynamic analysis](#dynamic-analysis)
  - [Sanitizers](#sanitizers)
  - [Valgrind](#valgrind)
- [CMake tips](#cmake-tips)
- [Doxygen tips](#doxygen-tips)
- [GitHub Actions tips](#github-actions-tips)
  - [Releases](#releases)
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

```sh
cmake --build .
# must specify the configuration with multi-config generators
ctest -C Debug
```

## Dynamic analysis

### Valgrind

```sh
ctest -T memcheck
# or
cmake --build . --target test_memcheck
# or, if using make
make test_memcheck
```

### Sanitizers

If using Clang, customize `SanitizerBlacklist.txt` at your will.

```sh
# Using gcc:
cmake .. -DCMAKE_CXX_FLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer"

# Using clang:
cmake .. -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer -fsanitize-blacklist=/full/path/to/SanitizerBlacklist.txt"

# Executing wxWidgets project with lsan suppressions:
ASAN_OPTIONS=detect_leaks=1 LSAN_OPTIONS=suppressions=../wx_lsan_suppressions.txt ./bin/projectwx
```

More about sanitizers: 
- https://hpc-wiki.info/hpc/Compiler_Sanitizers
- https://developers.redhat.com/blog/2021/05/05/memory-error-checking-in-c-and-c-comparing-sanitizers-and-valgrind

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

### Releases

A release is created when creating and pushing a tag that starts with `v`.

## Tutorial links

- [Mastering CMake](https://cmake.org/cmake/help/book/mastering-cmake/index.html)
- [CMake Reference Documentation](https://cmake.org/cmake/help/latest/index.html)
- [CMake Presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html)
- [Semantic Versioning](https://semver.org/)
- [CTest tutorial and options](https://coderefinery.github.io/cmake-workshop/testing/)
- [VS Code with CMake](https://code.visualstudio.com/docs/cpp/cmake-linux)
- For Sphinx instructions, see:
  - https://www.sphinx-doc.org/en/master/index.html
  - https://sphinx-themes.org/sample-sites/sphinx-rtd-theme
- [How to avoid the "Windows Defender SmartScreen prevented an unrecognized app from starting" warning](https://stackoverflow.com/a/66582477/3049315)