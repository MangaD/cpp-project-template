/**
 * @file MainFrame.hpp
 * @author David Gonçalves (11088596+MangaD@users.noreply.github.com)
 * @brief This class represents the main window.
 * @version 0.1
 * @date 2023-06-01
 *
 * @copyright Copyright (c) 2023 David Gonçalves
 */

#ifndef CPP_PROJ_MAINFRAME
#define CPP_PROJ_MAINFRAME

// For compilers that support precompilation, includes "wx/wx.h".
#include <wx/wxprec.h>

#ifndef WX_PRECOMP
	#include <wx/wx.h>
#endif

namespace cpp_proj
{

class App;

/**
 * @brief This class represents the main window.
 */
class MainFrame : public wxFrame
{
public:
	/**
	 * @brief Construct a new Main Frame object.
	 *
	 * @param[in] app
	 * @param[in] title
	 * @param[in] pos
	 * @param[in] size
	 */
	MainFrame(const App& app, const wxString& title, const wxPoint& pos,
	          const wxSize& size);

	~MainFrame() override = default;
	MainFrame(const MainFrame&) = delete;
	MainFrame& operator=(const MainFrame&) = delete;
	MainFrame(const MainFrame&&) = delete;
	MainFrame& operator=(const MainFrame&&) = delete;

private:
	static constexpr int LICENSE_COLUMN_WIDTH = 80;
	static constexpr int LOGO_FINAL_WIDTH = 114;
	static constexpr int LOGO_FINAL_HEIGHT = 128;

	void OnHello(wxCommandEvent& event);
	void OnExit(wxCommandEvent& event);
	void OnAbout(wxCommandEvent& event);
	wxDECLARE_EVENT_TABLE();

	const App& app_;

	// These will be deleted automatically at the end, using unique_ptr
	// would cause segmentation fault due to double deletion
	// https://docs.wxwidgets.org/trunk/overview_windowdeletion.html
	wxMenu* menuFile_;
	wxMenu* menuHelp_;
	wxMenuBar* menuBar_;

	wxIcon logoIco_;
};

}  // namespace cpp_proj

#endif  // CPP_PROJ_MAINFRAME
