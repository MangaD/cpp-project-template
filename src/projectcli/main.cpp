/**
 * @brief C++ Project Template
 *
 * A project template for C++ developers.
 *
 * @author MangaD
 *
 * @file
 */

#include <cassert>  // std::assert
#include <cstddef>  // std::size_t
#include <cstdlib>  // std::EXIT_SUCCESS, std::EXIT_FAILURE
#include <iostream>
#include <span>

#include "UserOpt.hpp"
#include "tutorial_1.hpp"

using namespace cpp_proj;

int main(int argc, char *argv[])
{
	assert(argc > 0);    // https://stackoverflow.com/q/2050961/3049315
	                     // https://stackoverflow.com/q/68878728/3049315
	progName = argv[0];  // NOLINT
	auto args = std::span(argv+1,  // NOLINT
	                      static_cast<std::size_t>(argc - 1));

	constexpr int i = 5;

	try
	{
		parseUserOptions(args);
	}
	catch (const std::exception &e)
	{
		std::cerr << e.what() << std::endl;
		// Do not call `exit` directly, so that the destructor
		// of the exception may be called.
		// https://stackoverflow.com/a/28931492/3049315
		return EXIT_FAILURE;
	}

	std::cout << "TESTING TUTORIAL 1:" << std::endl;
	std::cout << "\tFactorial of " << i << " is: " << tut1::factorial(i)
	          << std::endl;
}
