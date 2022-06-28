/**
 * @brief User options for this application.
 * @author MangaD
 * @file
 */

#ifndef CPP_PROJ_USEROPT_HPP
#define CPP_PROJ_USEROPT_HPP

#include <string_view>

/**
 * User options for this application.
 */
namespace cpp_proj
{

/**
 * This application's executable name, to be set at the start of the main
 * function.
 */
inline std::string_view
    progName;  // NOLINT: Yes, I know that global variables should
               // be constant (whenever possible) and carefully used.
               // In this case it should be fine.

/**
 * Gets the user options from the command line.
 *
 * @param argc The command line argument count.
 * @param argv An array of C-style strings containing the command line
 * arguments.
 *
 * @return void
 */
void parseUserOptions(int argc, char *argv[]);  // NOLINT

/**
 * Print the usage of the application.
 */
void printHelp();
/**
 * Print the version of the application.
 */
void printVersion();
/**
 * Calls DG_Tickingbot::printHelp and exits with success.
 */
[[noreturn]] void printHelpAndExit();
/**
 * Calls DG_Tickingbot::printVersion and exits with success.
 */
[[noreturn]] void printVersionAndExit();

}  // namespace cpp_proj

#endif
