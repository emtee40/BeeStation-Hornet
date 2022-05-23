/// Prepares a text to be used for maptext. Use this so it doesn't look hideous.
#define MAPTEXT(text) {"<span class='maptext'>[##text]</span>"}

/// Macro from Lummox used to get height from a MeasureText proc
#define WXH_TO_HEIGHT(x) text2num(copytext(x, findtextEx(x, "x") + 1))

#define WXH_TO_WIDTH(x) text2num(copytext(x, 1, findtextEx(x, "x") + 1))

#define CENTER(text) {"<center>[##text]</center>"}

#define SANITIZE_FILENAME(text) (GLOB.filename_forbidden_chars.Replace(text, ""))

/// Index of normal sized character size in runechat lists
#define NORMAL_FONT_INDEX 1

/// Index of small sized character size in runechat lists
#define SMALL_FONT_INDEX 2

/// Index of big sized character size in runechat lists
#define BIG_FONT_INDEX 3
