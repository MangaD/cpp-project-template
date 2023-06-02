#ifndef CPP_PROJ_COMPILER_H
#define CPP_PROJ_COMPILER_H

#define QUOTE(s) #s  // NOLINT

#ifdef __GNUC__
	#define DIAGNOSTIC_PUSH() _Pragma("GCC diagnostic push")
	#define DIAGNOSTIC_IGNORE(warning) \
		_Pragma(QUOTE(GCC diagnostic ignored warning))
	#define DIAGNOSTIC_POP() _Pragma("GCC diagnostic pop")
#else
	#define DIAGNOSTIC_PUSH()
	#define DIAGNOSTIC_IGNORE(warning)
	#define DIAGNOSTIC_POP()
#endif

#endif  // CPP_PROJ_COMPILER_H