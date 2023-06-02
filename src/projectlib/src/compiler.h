/**
 * @file compiler.h
 * @author David Gonçalves (11088596+MangaD@users.noreply.github.com)
 * @brief This file contains macros for ignoring compiler warnings.
 * @version 0.1
 * @date 2023-06-01
 *
 * @copyright Copyright (c) 2023 David Gonçalves
 */


#ifndef CPP_PROJ_COMPILER_H
#define CPP_PROJ_COMPILER_H

/**
 * @brief Turns the macro argument s into a string literal.
 * @note https://stackoverflow.com/a/61812123/3049315
 */
#define QUOTE(s) #s  // NOLINT

#ifdef __GNUC__
	#define DIAGNOSTIC_PUSH() _Pragma("GCC diagnostic push")
	#define DIAGNOSTIC_IGNORE(warning) \
		_Pragma(QUOTE(GCC diagnostic ignored warning))
	#define DIAGNOSTIC_POP() _Pragma("GCC diagnostic pop")
#else
	/**
	 * @brief GCC diagnostic push if using GCC. NOOP otherwise.
	 */
	#define DIAGNOSTIC_PUSH()
	/**
	 * @brief GCC diagnostic ignored if using GCC. NOOP otherwise.
	 */
	#define DIAGNOSTIC_IGNORE(warning)
	/**
	 * @brief GCC diagnostic pop if using GCC. NOOP otherwise.
	 */
	#define DIAGNOSTIC_POP()
#endif

#endif  // CPP_PROJ_COMPILER_H