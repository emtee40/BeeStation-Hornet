#define pick_list(FILE, KEY) (pick(strings(FILE, KEY)))
#define pick_list_weighted(FILE, KEY) (pickweight(strings(FILE, KEY)))
#define pick_list_replacements(FILE, KEY) (strings_replacement(FILE, KEY))
#define json_load(FILE) (json_decode(rustg_file_read(FILE)))

GLOBAL_LIST(string_cache)
GLOBAL_VAR(string_filename_current_key)


/proc/strings_replacement(filename, key)
	filename = SANITIZE_FILENAME(filename)
	load_strings_file(filename)

	if((filename in GLOB.string_cache) && (key in GLOB.string_cache[filename]))
		var/response = pick(GLOB.string_cache[filename][key])
		var/regex/r = regex("@pick\\((\\D+?)\\)", "g")
		response = r.Replace(response, /proc/strings_subkey_lookup)
		return response
	else
		CRASH("strings list not found: [STRING_DIRECTORY]/[filename], index=[key]")

/proc/strings(filename as text, key as text)
	filename = SANITIZE_FILENAME(filename)
	load_strings_file(filename)
	if((filename in GLOB.string_cache) && (key in GLOB.string_cache[filename]))
		return GLOB.string_cache[filename][key]
	else
		CRASH("strings list not found: [STRING_DIRECTORY]/[filename], index=[key]")

/proc/strings_subkey_lookup(match, group1)
	return pick_list(GLOB.string_filename_current_key, group1)

/proc/load_strings_file(filename)
	filename = SANITIZE_FILENAME(filename) // in case we're called directly
	GLOB.string_filename_current_key = filename
	if(filename in GLOB.string_cache)
		return //no work to do

	if(!GLOB.string_cache)
		GLOB.string_cache = new

	if(fexists("[STRING_DIRECTORY]/[filename]"))
		GLOB.string_cache[filename] = json_load("[STRING_DIRECTORY]/[filename]")
	else
		CRASH("file not found: [STRING_DIRECTORY]/[filename]")
