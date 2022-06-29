#ifndef CPP_PROJ_SPLASHSCREEN_HPP
#define CPP_PROJ_SPLASHSCREEN_HPP

// For compilers that support precompilation, includes "wx/wx.h".
#include <wx/wxprec.h>

#ifndef WX_PRECOMP
	#include <wx/wx.h>
#endif

void showSplashScreen(const wxString& fileName,
                      wxBitmapType bitmapType = wxBITMAP_TYPE_ANY);

void showSplashScreen(const wxImage& img);

wxImage alphaToBlackAndWhiteMask(const wxImage& img);

#endif  // CPP_PROJ_SPLASHSCREEN_HPP
