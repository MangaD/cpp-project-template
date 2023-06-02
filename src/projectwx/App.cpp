#include "App.hpp"

#include <wx/filename.h>  // wxFileName
#include <wx/splash.h>    // wxSplashScreen
#include <wx/stdpaths.h>  // wxStandardPaths

#include "MainFrame.hpp"
#include "config.h"
#include "splashscreen.hpp"

App::App()
    : appPath_(),
      logoImg_(),
      frame_(nullptr)
{
}

bool App::OnInit()
{
	/*
	 * Sets the name of the application.
	 * This name should be used for file names, configuration file entries
	 * and other internal strings. For the user-visible strings, such as the
	 * window titles, the application display name set by SetAppDisplayName()
	 * is used instead. By default the application name is set to the name of
	 * its executable file.
	 */
	SetAppName(CPP_PROJ_NAME);
	SetAppDisplayName(CPP_PROJ_NAME);

	// add handlers at startup
	wxImage::AddHandler(new wxPNGHandler);
	wxImage::AddHandler(new wxGIFHandler);

	/* When we compile resources with MinGW, we define
	 *    wxUSE_DPI_AWARE_MANIFEST=2
	 * which makes the app be DPI aware. This does not appear to work with
	 * MSVC, however.
	 */

	// Fixes blur on high dpi Windows
#if defined(_WIN32) && WINVER >= _WIN32_WINNT_VISTA
	SetProcessDPIAware();
#endif

	/*
	 * Get executable path
	 * https://stackoverflow.com/a/37726650/3049315
	 */
	wxFileName f(wxStandardPaths::Get().GetExecutablePath());
	appPath_ = f.GetPath();
	if (appPath_.EndsWith("Debug") || appPath_.EndsWith("Release"))
	{
		appPath_ += "/../";
	}
	else
	{
		appPath_ += "/";
	}

	logoImg_.LoadFile(appPath_ + logoPathRel_);

	showSplashScreen(this->logoImg_, SPLASHSCREEN_DURATION_MS);

	frame_ =
	    new MainFrame(this, CPP_PROJ_NAME, wxPoint(WINDOW_POS_X, WINDOW_POS_Y),
	                  wxSize(WINDOW_WIDTH, WINDOW_HEIGHT));
	frame_->Centre();
	frame_->Show(true);

	return true;
}

wxIMPLEMENT_APP(App);
