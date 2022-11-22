# Development Guide

- [Autoformatting](#autoformatting)
- [Static analysis](#static-analysis)
- [Testing](#testing)
- [Dynamic analysis](#dynamic-analysis)
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
cmake --build . --target tidy
# or, if using make:
make tidy
```

With `cppcheck`:

```sh
cmake --build . --target cppcheck
# or, if using make:
make cppcheck
```

## Testing

```sh
cmake --build .
# must specify the configuration with multi-config generators
ctest -C Debug
```

## Dynamic analysis

Memory check with Valgrind:

```sh
ctest -T memcheck
# or
cmake --build . --target test_memcheck
# or, if using make
make test_memcheck
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
- [CTest tutorial and options](https://coderefinery.github.io/cmake-workshop/testing/)
- For Sphinx instructions, see:
  - https://www.sphinx-doc.org/en/master/index.html
  - https://sphinx-themes.org/sample-sites/sphinx-rtd-theme