hecc
====

An extremely basic Atom feed generator built out of necessity.  Only dependency
is `cmark`.

Usage is simple:

  1. Create a folder called `posts`.
  2. Write stuff in Markdown, save the file using the date as the name in the
     following format: `YYYY-MM-DD.md`.  If the first line is H1, that will be
     the entry title; otherwise, the title will be the date.
  3. Copy the file `sample-settings.sh` to `settings.sh` (or just rename it, if
     you're not pulling this as a git repo), then edit with your site's deets.
  4. Execute `./hecc` on your terminal.
  5. Upload that feed wherever.

Example post file:

```md
Post title
==========

Post begins here.  It's just regular ol' markdown, so do whatever.
```

The title can use either the above format or the simpler `# Post title` format.
That's pretty much the only thing that matters here.


Possible future niceties
------------------------

The script is pretty much finished as-is, but there are a couple things we'd
like to tweak for future comfort.  **These are absolutely not needed,** but
they'd be very nice to have.

  - [ ] some kind of ID "database" (to prevent repeats)
  - [ ] a different ID format (to allow filename changes)
  - [ ] format for adding update timestamps to filename (tentative:
    `[original-date]_[last-update].md`)
  - [ ] allow for time to be added to filename (examples:
    `2024-10-17T02:12:00-04:00.md`, `2024-10-17T02:12:00.md`)
