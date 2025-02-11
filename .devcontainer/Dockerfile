# https://github.com/devcontainers/images/tree/main/src
# https://hub.docker.com/_/microsoft-vscode-devcontainers
# https://github.com/microsoft/vscode-dev-containers/tree/main/containers/cpp
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/cpp:0-${VARIANT}

RUN apt-get update && apt-get upgrade -y
RUN apt-get update \
	&& apt-get install -y git cmake make ninja-build \
		build-essential clang llvm libwxgtk3.2-dev graphviz doxygen sphinx-common \
		python3-breathe python3-sphinx-rtd-theme cppcheck clang-tidy clang-format \
		gdb lldb valgrind dpkg rpm libgtest-dev lcov gcovr \
	&& apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
