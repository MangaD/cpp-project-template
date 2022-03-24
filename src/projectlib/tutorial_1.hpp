#ifndef TUT1_HPP
#define TUT1_HPP

namespace tut1
{

template <typename T>
constexpr T factorial(T n)
{
	T res = 1;
	for (auto i = 2; i <= n; ++i)
	{
		res *= i;
	}
	return res;
}

}  // namespace tut1

#endif
