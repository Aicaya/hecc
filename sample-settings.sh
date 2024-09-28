# ===== SITE CONFIGURATION ===== #

# Feed info
FEED_TITLE="someone's feed"
FEED_AUTHOR="your name"
FEED_SUBTITLE="a short summary"

# Website where the feed will be hosted
WEBSITE="https://example.com/"

# Location of feed within the site
FEED_LOC="/feed.atom.xml"

# (Optional) Timezone offset -- will default to "Z" (UTC) if empty
TIMEZONE="-04:00"

# ----- Advanced settings ----- #

# Markdown command to be used by awk script.  Only modify if you know what
# you're doing.
# (Note: If using Discount, do not add 'cdata' flag.  Awk script handles that.)
MD_CMD="cmark --to html --unsafe --smart --validate-utf8"

# Awk command to be used by script.  DEFINITELY do not modify unless you know
# what you're doing.
# Implementations tested so far: gawk, nawk, mawk
AWK_CMD="awk"
