/**
 * @file App.hpp
 * @author David Gonçalves (11088596+MangaD@users.noreply.github.com)
 * @brief This class is the entry point for this wxWidgets app.
 * @version 0.1
 * @date 2023-06-01
 *
 * @copyright Copyright (c) 2023 David Gonçalves
 */

#ifndef CPP_PROJ_APP
#define CPP_PROJ_APP

// #undef __GXX_ABI_VERSION
// #define __GXX_ABI_VERSION 1013 //XXX Better way to do this?

// For compilers that support precompilation, includes "wx/wx.h".
#include <wx/wxprec.h>

#ifndef WX_PRECOMP
	#include <wx/wx.h>
#endif

#include "MainFrame.hpp"

/**
 * @brief Namespace for this application.
 */
namespace cpp_proj
{

/**
 * @brief This class is the entry point for this wxWidgets app.
 */
class App : public wxApp
{
public:
	/**
	 * @brief The wxWidgets equivalent of a main procedure.
	 *
	 * @note https://docs.wxwidgets.org/3.0/overview_app.html
	 *
	 * @return True if processing should continue, false otherwise.
	 */
	bool OnInit() override;

	App();
	~App() override = default;
	App(const App&) = delete;
	App& operator=(const App&) = delete;
	App(App&&) = delete;
	App& operator=(App&&) = delete;

	/**
	 * @brief Get the Logo Img object.
	 *
	 * @return The logo image.
	 */
	const wxImage& getLogoImg() const { return logoImg_; }

private:
	static constexpr int WINDOW_POS_X = 50;
	static constexpr int WINDOW_POS_Y = 50;
	static constexpr int WINDOW_WIDTH = 1200;
	static constexpr int WINDOW_HEIGHT = 800;

	static constexpr int SPLASHSCREEN_DURATION_MS = 3000;

	const wxString logoPathRel_ = "../images/logo.png";

	wxString appPath_;
	wxImage logoImg_;

	// These will be deleted automatically at the end, using unique_ptr
	// would cause segmentation fault due to doyble deletion
	// https://docs.wxwidgets.org/trunk/overview_windowdeletion.html
	MainFrame* frame_;
};

}  // namespace cpp_proj

#endif  // CPP_PROJ_APP
