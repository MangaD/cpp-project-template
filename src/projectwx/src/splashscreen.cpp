#include "splashscreen.hpp"

#include <wx/splash.h>  // wxSplashScreen

#include <cstddef>
#include <span>

void showSplashScreen(const wxString& fileName, const unsigned long durationMs,
                      const wxBitmapType bitmapType)
{
	wxImage splashImg;
	if (splashImg.LoadFile(fileName, bitmapType))
	{
		showSplashScreen(splashImg, durationMs);
	}
}

// Splash screen
// https://forums.wxwidgets.org/viewtopic.php?t=10997
// https://openclassrooms.com/forum/sujet/wxwidgets-comment-creer-une-image-flottante#message-86763288
void showSplashScreen(const wxImage& splashImg, const unsigned long durationMs)
{
	if (!splashImg.IsOk()) return;

	bool hasAlpha = splashImg.HasAlpha() || splashImg.HasMask();

	wxRegion splashRgn;
	if (hasAlpha)
	{
		splashRgn = wxRegion(alphaToBlackAndWhiteMask(splashImg), *wxWHITE);
	}
	wxSplashScreen scrn{
	    splashImg,
	    wxSPLASH_CENTRE_ON_SCREEN | wxSPLASH_TIMEOUT,
	    static_cast<int>(durationMs),
	    nullptr,
	    -1,
	    wxDefaultPosition,
	    wxDefaultSize,
	    wxBORDER_NONE | wxSTAY_ON_TOP | (hasAlpha ? wxFRAME_SHAPED : 0x00)};
	if (hasAlpha)
	{
		scrn.SetShape(splashRgn);
	}
	// scrn.SetTransparent(150);

	// yield main loop so splash screen can show
	wxYield();
	// Sleep for `durationMs/1000` seconds before destroying the splash screen
	// and showing main frame
	wxMilliSleep(durationMs);
}

// https://openclassrooms.com/forum/sujet/wxwidgets-comment-creer-une-image-flottante#message-86763288
// Doesn't work well for alpha compositing
wxImage alphaToBlackAndWhiteMask(const wxImage& imgParam)
{
	constexpr int maxAlphaValue = 20;
	constexpr unsigned char white = 0xFF;
	constexpr unsigned char black = 0x00;

	// Must create a copy by calling the Copy method. The copy constructor
	// of wxImage has both objects sharing the same underlying data.
	wxImage img = imgParam.Copy();

	// Some image types (e.g. gif) have a mask for the transparent pixels
	// instead of an alpha channel.
	if (!img.HasAlpha() && img.HasMask())
	{
		img.InitAlpha();
	}

	if (img.HasAlpha())
	{
		std::size_t imgPixelCount = static_cast<std::size_t>(img.GetWidth()) *
		                            static_cast<std::size_t>(img.GetHeight());

		std::span<unsigned char> rgb(img.GetData(), imgPixelCount * 3);
		std::span<unsigned char> alpha(img.GetAlpha(), imgPixelCount);

		for (std::size_t i = 0; auto& a : alpha)
		{
			// If alpha pixel, make white. Else make black.
			// An alpha value of 0 corresponds to a transparent pixel (null
			// opacity) while a value of 255 means that the pixel is 100%
			// opaque.
			if (a < maxAlphaValue)
			{  // Using some threshold for almost transparent pixels.
				rgb[i] = white;      // red
				rgb[i + 1] = white;  // green
				rgb[i + 2] = white;  // blue
			}
			else
			{
				rgb[i] = black;      // red
				rgb[i + 1] = black;  // green
				rgb[i + 2] = black;  // blue
			}
			i += 3;
		}

		// Remove alpha channel so that the pixels turned white will show
		img.ClearAlpha();
	}

	return img;
}
