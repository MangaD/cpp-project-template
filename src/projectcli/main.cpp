/**
 * @file main.cpp
 * @author David Gonçalves (11088596+MangaD@users.noreply.github.com)
 * @brief A project template for C++ developers.
 * @version 0.1
 * @date 2023-06-01
 *
 * @copyright Copyright (c) 2023 David Gonçalves
 */

#include <cassert>  // std::assert
#include <cstddef>  // std::size_t
#include <cstdlib>  // std::EXIT_SUCCESS, std::EXIT_FAILURE
#include <iostream>
#include <span>

#include "UserOpt.hpp"
#include "tutorial_1.hpp"

using namespace cpp_proj;

/**
 * @brief Application's entry point.
 *
 * @param[in] argc Count of arguments passed to this program.
 * @param[in] argv Array of arguments passed to this program.
 *
 * @return This application's exit status.
 */
int main(int argc, char *argv[])
{
	assert(argc > 0);    // https://stackoverflow.com/q/2050961/3049315
	                     // https://stackoverflow.com/q/68878728/3049315
	progName = argv[0];  // NOLINT
	auto args = std::span(argv + 1,  // NOLINT
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
