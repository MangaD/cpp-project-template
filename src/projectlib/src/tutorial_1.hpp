#ifndef TUT1_HPP
#define TUT1_HPP

#include <concepts>  // std::integral

namespace tut1
{

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
