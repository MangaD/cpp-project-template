/**
 * @brief User options for this application.
 * @author MangaD
 * @file
 */

#ifndef CPP_PROJ_USEROPT_HPP
#define CPP_PROJ_USEROPT_HPP

#include <span>
#include <string_view>

/**
 * @brief Namespace for this application.
 */
namespace cpp_proj
{

/**
 * @brief This application's executable name, to be set at the start of the main
 * function.
 */
inline std::string_view
    progName;  // NOLINT: Yes, I know that global variables should
               // be constant (whenever possible) and carefully used.
               // In this case it should be fine.

/**
 * @brief Gets the user options from the command line.
 *
 * @param args The command line arguments.
 */
void parseUserOptions(const std::span<char*>& args);

/**
 * @brief Print the usage of the application.
 */
void printHelp();
/**
 * @brief Print the version of the application.
 */
void printVersion();
/**
 * @brief Calls \ref cpp_proj::printHelp and exits with success.
 */
[[noreturn]] void printHelpAndExit();
/**
 * @brief Calls \ref cpp_proj::printVersion and exits with success.
 */
[[noreturn]] void printVersionAndExit();

}  // namespace cpp_proj

#endif
