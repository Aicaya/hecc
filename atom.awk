# atom.awk
# A very basic Atom feed generator made out of necessity.

# -----
# Copyright (c) 2024 Aicaya Maro
#
# This program is free software.  It comes without any warranty, to the extent
# permitted by applicable law.  You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License, Version 2, as
# published by Sam Hocevar.  See the COPYING file for more details.
# -----

# get date from filename
date == "" {
	date = get_date(FILENAME)
	if (date == "") {
		error("cannot get date from filename (format: YYYY-MM-DD.md)")
		nextfile
	}
}

# get entry title from first line (must be h1)
FNR == 1 {
	if ($1 == "#") {
		sub(/^# +/, "", $0)
		got_title = 1
	}

	title = clean_html($0)
	next
}

# verify that first line was h1; otherwise, use date as title
FNR == 2 {
	if (title !~ /^[ \t]*$/ && $0 ~ /^===+$/)
		next
	else if (got_title + 0 == 0)
		title = date
}

{
	out = datadir "/" date ".xml"
	printf("%s\n", replace_labels(template)) > out

	if (title == date)
		cmd = markdown_cmd " " FILENAME
	else
		cmd = "tail -n +" FNR " " FILENAME " | " markdown_cmd

	while (cmd | getline)
		print clean_html($0) > out
	close(cmd)

	printf("%s\n", "</content>") > out
	printf("%s\n", "</entry>") > out
	close(out)

	reset()
	nextfile
}

# ----------------- #

function error(msg)
{
	printf("%s: %s\n", FILENAME, msg)
	reset()
}

# Clean up environment in preparation for next file
function reset()
{
	title = ""
	date = ""
	id = ""
}

# Convert '&', '<' and '>' into HTML entities.
function clean_html(line)
{
	gsub(/&/, "\\&amp;", line)
	gsub(/</, "\\&lt;", line)
	gsub(/>/, "\\&gt;", line)
	return line
}

# Escape every '\' and '&' so line can be used as second arg in [g]sub().
function clean_line(line)
{
	gsub(/\\/, "\x01\x01", line)
	gsub(/\x01/, "\\", line)
	gsub(/&/, "\\\\&", line)
	return line
}

function get_date(line,        _d)
{
	sub(/^.*\//, "", line)
	sub(/\.md$/, "", line)
	if (split(line, _d, "-") == 3 &&
	    is_date_valid(_d[1], int(_d[2]), int(_d[3]) != 0))
		return line
}

function is_date_valid(year, month, day,        _is_leap)
{
	if (year <= 0 || month < 1 || month > 12 || day < 1)
		return 0

	_is_leap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))

	# line 1: February
	# line 2: January-July (even = 30, odd = 31)
	# line 3: August-December (even = 31, odd = 30)
	return ((month == 2 && ((_is_leap == 1  && day <= 29) || day <= 28)) ||
	        (month <= 7 && ((month % 2 == 0 && day <= 30) || day <= 31)) ||
	                       ((month % 2 == 0 && day <= 31) || day <= 30))
}

function create_id(_site, _file, _out)
{
	_site = site
	_file = FILENAME

	sub(/^[^:]*:\/\//, "", _site)
	sub(/\/.*$/, "", _site)
	sub(/.*\//, "", _file)
	gsub(/ /, "_", _file)

	_out = "tag:" _site "," date ":" _file
	return _out
}

function replace_labels(t) {
	sub(/%%title%%/, clean_line(clean_html(title)), t)
	sub(/%%id%%/, create_id(), t)
	sub(/%%date%%/, date, t)
	sub(/%%tz%%/, timezone, t)
	return t
}
