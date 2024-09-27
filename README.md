hecc
====

An extremely basic Atom feed generator built out of necessity.  Only dependency
is `cmark`.

Usage is simple:

1. Create a folder called `posts`.
2. Write stuff in Markdown, save the file using the date as the name in the
   following format: `YYYY-MM-DD.md`.  If the first line is H1, that will be the
   entry title; otherwise, the title will be the date.
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

### Wait, but what about [x] feature?

Listen, we made this thing 'cause Cohost is going down and we needed *something*
we could set up easily on our other alias without our ADHD getting in the way.
We're not going to add any more features to this unless it's absolutely, 1000%
necessary.

This tiny little tool is now complete.  Anything beyond here is just bug fixing.
