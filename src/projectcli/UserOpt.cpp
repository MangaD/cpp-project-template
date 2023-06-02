#include "UserOpt.hpp"

#include <iostream>
#include <stdexcept>  // std::runtime_error
#include <string>
#include <string_view>
#include <vector>

#include "config.h"

namespace cpp_proj
{

void printHelp()
{
	std::cout << "Usage: " << progName << "\n\n"
	          << "-h, --help\tdisplay this help and exit\n"
	          << "-v, --version\toutput version information and exit."
	          << std::endl;
}

void printVersion()
{
	std::cout << CPP_PROJ_NAME << " " << CPP_VERSION_MAJOR << "."
	          << CPP_VERSION_MINOR << "." << CPP_VERSION_PATCH << "."
	          << CPP_VERSION_TWEAK << "\n"
	          << CPP_DESCRIPTION << "\n"
	          << CPP_HOMEPAGE_URL << std::endl;
}

void printHelpAndExit()
{
	printHelp();
	exit(EXIT_SUCCESS);
}

void printVersionAndExit()
{
	printVersion();
	exit(EXIT_SUCCESS);
}

void parseUserOptions(int argc, char *argv[])  // NOLINT
{
	// First argument is the program's name. Next argument *must* be a flag.
	if (argc < 2)
	{
		return;
	}

	std::vector<std::string_view> args(argv + 1, argv + argc);

	// May have more than one flag enabled in the future.
	// NOLINTNEXTLINE
	for (auto i = args.begin(); i != args.end(); ++i)
	{
		if (*i == "-h" || *i == "--help")
		{
			printHelpAndExit();
		}
		else if (*i == "-v" || *i == "--version")
		{
			printVersionAndExit();
		}
		else
		{
			throw std::runtime_error(std::string("Option not recognized: ") +
			                         std::string(*i));
		}
	}
}

}  // namespace cpp_proj
