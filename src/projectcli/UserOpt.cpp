#include "UserOpt.hpp"

#include <iostream>
#include <span>
#include <stdexcept>  // std::runtime_error
#include <string>
#include <string_view>

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

void parseUserOptions(const std::span<char*>& args)
{
	if (args.size() == 0)
	{
		return;
	}

	// May have more than one flag enabled in the future.
	// NOLINTNEXTLINE
	for (std::string_view arg : args)
	{
		if (arg == "-h" || arg == "--help")
		{
			printHelpAndExit();
		}
		else if (arg == "-v" || arg == "--version")
		{
			printVersionAndExit();
		}
		else
		{
			using namespace std::string_literals;
			throw std::runtime_error("Option not recognized: "s +
			                         std::string(arg));
		}
	}
}

}  // namespace cpp_proj
