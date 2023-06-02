#include "MainFrame.hpp"

#include <wx/aboutdlg.h>  // wxAboutDialogInfo, wxAboutBox

#include <ctime>  // std::time, std::localtime
#include <string>

#include "App.hpp"
#include "compiler.h"
#include "config.h"
#include "utils.hpp"

enum
{
	ID_Hello = 1
};

MainFrame::MainFrame(const App* app, const wxString& title, const wxPoint& pos,
                     const wxSize& size)
    : wxFrame(nullptr, wxID_ANY, title, pos, size),
      app_(app),
      menuFile_(new wxMenu),
      menuHelp_(new wxMenu),
      menuBar_(new wxMenuBar),
      logoIco_()
{
	// About mnemonics:
	// https://www.wxwidgets.org/docs/tutorials/using-mnemonics/
	// Add & before the letter
	menuFile_->Append(ID_Hello, "&Hello...\tCtrl-H",
	                  _("Help string shown in status bar for this menu item"));
	menuFile_->AppendSeparator();
	menuFile_->Append(wxID_EXIT);

	menuHelp_->Append(wxID_ABOUT);

	menuBar_->Append(menuFile_, "&File");
	menuBar_->Append(menuHelp_, "&Help");

	SetMenuBar(menuBar_);

	CreateStatusBar();
	SetStatusText(_("Welcome to the C++ Project Template!"));

	if (app_->getLogoImg().IsOk())
	{
		wxBitmap logoBm{
		    app_->getLogoImg().Scale(LOGO_FINAL_WIDTH, LOGO_FINAL_HEIGHT)};
		logoIco_.CopyFromBitmap(logoBm);
		SetIcon(logoIco_);
	}
}

void MainFrame::OnExit(wxCommandEvent& WXUNUSED(event)) { Close(true); }

void MainFrame::OnAbout(wxCommandEvent& WXUNUSED(event))
{
	wxAboutDialogInfo info;
	info.SetName(wxString::FromUTF8(CPP_PROJ_NAME));
	info.SetVersion(std::to_string(CPP_VERSION_MAJOR) + "." +
	                std::to_string(CPP_VERSION_MINOR) + "." +
	                std::to_string(CPP_VERSION_PATCH) + "." +
	                std::to_string(CPP_VERSION_TWEAK));

	info.SetIcon(logoIco_);

	info.SetDescription(wxString::FromUTF8(CPP_DESCRIPTION));
	info.SetWebSite(wxString::FromUTF8(CPP_HOMEPAGE_URL));
	// Call of AddDeveloper() method adds a record to list of developers
	info.AddDeveloper(wxString::FromUTF8(CPP_AUTHOR));
	// Call of AddDocWriter() method adds a record to list of documentation
	// writers
	info.AddDocWriter(wxString::FromUTF8(CPP_AUTHOR));
	/*
	    for (auto& s : app_artists)
	    {
	        // Call of AddArtist() method adds a record to list of artists
	        info.AddArtist(s);
	    }

	    for (auto& s : app_translators)
	    {
	        // Call of AddTranslator() method adds a record to list of
	   translators info.AddTranslator(s);
	    }
	*/
	std::time_t t = std::time(nullptr);
	std::tm* const tm = std::localtime(&t);
	constexpr int TM_YEAR_BASE = 1900;
	info.SetCopyright(wxString::FromUTF8(
	    (std::string("Copyright (c) ") +
	     std::to_string(TM_YEAR_BASE + tm->tm_year) + " " + CPP_AUTHOR)
	        .c_str()));

	/*
	 * Set the long, multiline string containing the text of the program
	 * licence. Only GTK+ version supports showing the licence text in the
	 * native about dialog currently so the generic version will be used under
	 * all the other platforms if this method is called. To preserve the native
	 * look and feel it is advised that you do not call this method but provide
	 * a separate menu item in the "Help" menu for displaying the text of your
	 * program licence.
	 */
	std::string license(CPP_LICENSE);
#ifndef _WIN32
	license = wordWrap(license, LICENSE_COLUMN_WIDTH);
#endif
	info.SetLicence(wxString::FromUTF8(license.c_str()));

	// At last, we can display about box
	wxAboutBox(info, this);
}

void MainFrame::OnHello(wxCommandEvent& WXUNUSED(event))
{
	/*
	 * For literal strings with Unicode characters, it is important to never
	 * use 8-bit (instead of 7-bit) characters directly in the program source
	 * but use wide strings. If reading the string from a file, use
	 * wxString::FromUTF8.
	 * https://docs.wxwidgets.org/trunk/overview_unicode.html
	 */
	wxLogMessage(_("Hello world from wxWidgets!\n") + L"Salut \u00E0 toi!");
}

// clang-format off
DIAGNOSTIC_PUSH()
DIAGNOSTIC_IGNORE("-Wzero-as-null-pointer-constant")
wxBEGIN_EVENT_TABLE(MainFrame, wxFrame) EVT_MENU(ID_Hello, MainFrame::OnHello)
EVT_MENU(wxID_EXIT, MainFrame::OnExit)
EVT_MENU(wxID_ABOUT, MainFrame::OnAbout) wxEND_EVENT_TABLE()
DIAGNOSTIC_POP()
    // clang-format on
