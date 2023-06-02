/**
 * @file tutorial_1.hpp
 * @author David Gonçalves (11088596+MangaD@users.noreply.github.com)
 * @brief This file contains example code for learning purposes.
 * @version 0.1
 * @date 2023-06-01
 *
 * @copyright Copyright (c) 2023 David Gonçalves
 */


#ifndef TUT1_HPP
#define TUT1_HPP

#include <concepts>  // std::integral

/**
 * @brief The namespace for this tutorial.
 */
namespace tut1
{

/**
 * @brief Calculate the factorial of a given integral number.
 * 
 * @param[in] n The number to calculate the factorial of.
 * @return The calculated factorial.
 */
constexpr std::integral auto factorial(std::integral auto n)
{
	std::integral auto res = 1;
	for (auto i = 2; i <= n; ++i)
	{
		res *= i;
	}
	return res;
}

}  // namespace tut1

#endif
