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
#include <cstdlib>  // std::EXIT_SUCCESS, std::EXIT_FAILURE
#include <iostream>

#include "UserOpt.hpp"
#include "tutorial_1.hpp"

using namespace cpp_proj;

int main(int argc, char *argv[])
{
	assert(argc > 0);    // NOLINT https://stackoverflow.com/q/2050961/3049315
	                     // https://stackoverflow.com/q/68878728/3049315
	progName = argv[0];  // NOLINT: Pointer arithmetic is inevitable here.

	constexpr int i = 5;

	try
	{
		parseUserOptions(argc, argv);
	}
	catch (const std::exception &e)
	{
		std::cerr << e.what() << std::endl;
		exit(EXIT_FAILURE);
	}

	std::cout << "TESTING TUTORIAL 1:" << std::endl;
	std::cout << "\tFactorial of " << i << " is: " << tut1::factorial(i) << std::endl;
}
