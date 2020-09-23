/datum/star_system
	var/name = "Sol"
	var/unique_id = 0
	var/map_x = 100	//Between 0 and 1000
	var/map_y = 100 //Between 0 and 1000
	var/list/linked_stars = list()

	var/visited = FALSE
	var/star_color = "#ffffff"

	var/is_station_z = FALSE

	//572 possible names
	var/static/list/first_symbols = list(
		"h", "v", "c", "e", "g", "d", "r", "n", "h", "o", "p",
		"ra", "so", "at", "il", "ta", "sh", "ya", "te", "sh", "ol", "ma", "om", "ig", "ni", "in"
	)
	var/static/list/second_symbols = list(
		"na", "ba", "da", "ne", "le", "la", "ol",
		"nar", "nie", "bie", "bar", "nar", "raw", "car", "lar", "lim", "dim", "rak",
		"romeda", "retigo", "liga", "risoft"
	)

	var/distance_from_center = 0

	var/datum/star_system_data/system_data

	//After generation
	var/system_alignment
	var/calculated_threat
	var/calculated_research_potential = 0

	//Which ruin pool to pull from
	var/bluespace_ruins = FALSE

/datum/star_system/New(distance)
	. = ..()
	var/static/stars = 0
	unique_id = stars ++
	//Get a realistic star colour
	star_color = pick(STAR_COLORS)
	//Generate a name (We will just use nar'sian names because it sounds ok)
	name = capitalize("[pick(first_symbols)][pick(second_symbols)]-[pick(GLOB.hex_characters)][pick(GLOB.hex_characters)]")
