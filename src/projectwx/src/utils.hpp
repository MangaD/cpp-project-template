/**
 * @file utils.hpp
 * @author David Gonçalves (11088596+MangaD@users.noreply.github.com)
 * @brief This file contains utility functions.
 * @version 0.1
 * @date 2023-06-01
 *
 * @copyright Copyright (c) 2023 David Gonçalves
 */

#ifndef CPP_PROJ_UTILS
#define CPP_PROJ_UTILS

#include <string>

namespace cpp_proj
{

/**
 * @brief Breaks a string into multiple lines, each not exceeding the specified width.
 * 
 * @param[in] str The string to break into multiple lines
 * @param[in] width The maximum number of characters each line can have.
 * @return The string broken into multiple lines.
 */
std::string wordWrap(const std::string &str, size_t width);

}  // namespace cpp_proj

#endif  // CPP_PROJ_UTILS
