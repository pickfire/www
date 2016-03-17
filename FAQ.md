Frequently Asked Questions (FAQ)
================================

## How do I **build on the fly** like `jekyll serve`?

Use `find | entr sh -c 'make'` to build when files have changed. In addition,
replace `make` with `pkill surf` or kill the surf pid to reload the browser
on the fly.

## How do I build it together with a few slow computers (cluster computing)?

I am still researching this.
