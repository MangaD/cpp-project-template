#include "splashscreen.hpp"

#include <wx/splash.h>  // wxSplashScreen

void showSplashScreen(const wxString& fileName, wxBitmapType bitmapType)
{
	wxImage splashImg;
	if (splashImg.LoadFile(fileName, bitmapType))
	{
		showSplashScreen(splashImg);
	}
}

// Splash screen
// https://forums.wxwidgets.org/viewtopic.php?t=10997
// https://openclassrooms.com/forum/sujet/wxwidgets-comment-creer-une-image-flottante#message-86763288
void showSplashScreen(const wxImage& splashImg)
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
		5000,
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
	// Sleep for two seconds before destroying the splash screen and showing
	// main frame
	wxSleep(2);
}

// https://openclassrooms.com/forum/sujet/wxwidgets-comment-creer-une-image-flottante#message-86763288
// Doesn't work well for alpha compositing
wxImage alphaToBlackAndWhiteMask(const wxImage& imgParam)
{
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
		unsigned char *rgb = img.GetData();
		unsigned char *alpha = img.GetAlpha();

		for (int x = 0, y = 0; x < img.GetWidth() * img.GetHeight() * 3;
		     x += 3, y++)
		{
			// If alpha pixel, make white. Else make black.
			// An alpha value of 0 corresponds to a transparent pixel (null
			// opacity) while a value of 255 means that the pixel is 100%
			// opaque.
			if (alpha[y] < 20)
			{  // Using some threshold for almost transparent pixels.
				rgb[x] = 0xff;      // red
				rgb[x + 1] = 0xff;  // green
				rgb[x + 2] = 0xff;  // blue
			}
			else
			{
				rgb[x] = 0x00;      // red
				rgb[x + 1] = 0x00;  // green
				rgb[x + 2] = 0x00;  // blue
			}
		}

		// Remove alpha channel so that the pixels turned white will show
		img.ClearAlpha();
	}

	return img;
}
