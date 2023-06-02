#include <gtest/gtest.h>

#include "tutorial_1.hpp"

// Demonstrate some basic assertions.
TEST(HelloTest, BasicAssertions)
{
	// Expect two strings not to be equal.
	EXPECT_STRNE("hello", "world");
	// Expect equality.
	EXPECT_EQ(7 * 6, 42);
}

TEST(Tutorial1, Factorial) { EXPECT_EQ(tut1::factorial(4), 24); }

int main(int argc, char **argv)
{
	testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}