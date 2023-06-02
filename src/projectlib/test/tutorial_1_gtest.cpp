/**
 * @file tutorial_1_gtest.cpp
 * @author David Gonçalves (11088596+MangaD@users.noreply.github.com)
 * @brief This file contains unit tests for the functions in \ref tutorial_1.hpp.
 * @version 0.1
 * @date 2023-06-01
 *
 * @copyright Copyright (c) 2023 David Gonçalves
 */

#include <gtest/gtest.h>

#include "tutorial_1.hpp"

/**
 * @brief Demonstrate some basic assertions.
 */
TEST(HelloTest, BasicAssertions)
{
	// Expect two strings not to be equal.
	EXPECT_STRNE("hello", "world");
	// Expect equality.
	EXPECT_EQ(7 * 6, 42);
}

/**
 * @brief Test the factorial function.
 */
TEST(Tutorial1, Factorial) { EXPECT_EQ(tut1::factorial(4), 24); }

/**
 * @brief Entry point for running our unit tests.
 */
int main(int argc, char **argv)
{
	testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}