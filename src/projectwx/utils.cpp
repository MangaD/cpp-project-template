#include "utils.hpp"

#include <sstream>
#include <string>
#include <vector>

std::string wordWrap(std::string &s, size_t width)
{
	std::stringstream ss(s);
	std::string line;
	std::vector<std::string> lines;

	while (std::getline(ss, line, '\n'))
	{
		while (line.size() > width)
		{
			auto index = line.find_last_of(' ', width);

			if (index == std::string::npos)
			{
				index = width;
			}
			lines.push_back(line.substr(0, index));
			line = line.substr(index + (index == std::string::npos ? 0 : 1));
		}
		lines.push_back(line);
	}

	std::string out;
	for (const auto &s2 : lines)
	{
		out += s2 + '\n';
	}

	return out;
}
