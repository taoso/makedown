# Makedown - Makefile based Markdown Blogging

Markdown is a simple blogging toolchain based on makefile.

## Quick Start

You only need to install the make, bash and pandoc.

Then clone this repository.

```bash
git clone https://github.com/taoso/makedown.git
```

With makedown, you can create a new blog. You need to offer the blog dir.

```bash
make -f path/to/makedown/Makefile new dir=hello
```

After this, you can build html for markdown file.

```bash
cd hello
make -f path/to/makedown/Makefile build
```

```bash
python3 -m http.server
```

Finally, open http://localhost:8000 to see the generated website.

## Customization

Let's `$root` represent the directory of blog.

You need to custom some site data in the `$root/env` file:

```bash
site_title=makedown
site_url=https://example.com
author_name=Bob
author_email=bob@example.com
```

While most of this info are mainly used for generating Atom feed, the `$site_title`
will also be used for generating index.html for all directories.

The template file `$root/article.tpl` is used for generating html for markdown.
And the template file `$root/index.tpl` is used for generating all index.html[s].

Both two files are the standard pandoc template.

While the index.html generated for the top root directory will contain links for
all markdown's html files, the index.html in one sub-directory only contains the
html in this directory.
