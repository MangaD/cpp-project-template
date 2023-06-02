/**
 * @file splashscreen.hpp
 * @author David Gonçalves (11088596+MangaD@users.noreply.github.com)
 * @brief This class represents the splashscreen.
 * @version 0.1
 * @date 2023-06-01
 *
 * @copyright Copyright (c) 2023 David Gonçalves
 */

#ifndef CPP_PROJ_SPLASHSCREEN_HPP
#define CPP_PROJ_SPLASHSCREEN_HPP

// For compilers that support precompilation, includes "wx/wx.h".
#include <wx/wxprec.h>

#ifndef WX_PRECOMP
	#include <wx/wx.h>
#endif

namespace cpp_proj
{

/**
 * @brief Shows the splashscreen.
 *
 * @param[in] fileName The splashscreen image file path.
 * @param[in] durationMs The duration of the splashscreen.
 * @param[in] bitmapType The image file type of the splashscreen.
 */
void showSplashScreen(const wxString& fileName, const unsigned long durationMs,
                      const wxBitmapType bitmapType = wxBITMAP_TYPE_ANY);

/**
 * @brief Shows the splashscreen.
 *
 * @param[in] img The splashscreen image.
 * @param[in] durationMs The duration of the splashscreen.
 */
void showSplashScreen(const wxImage& img, const unsigned long durationMs);

/**
 * @brief Creates a black & white mask for the alpha channel.
 *
 * @param[in] img The image to create the mask for.
 *
 * @return wxImage The black & white mask for the alpha channel.
 */
wxImage alphaToBlackAndWhiteMask(const wxImage& img);

}  // namespace cpp_proj

#endif  // CPP_PROJ_SPLASHSCREEN_HPP
