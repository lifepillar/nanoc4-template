# Nanoc by Lifepillar

This is a starting point for a web site built with [Nanoc](http://nanoc.ws/).
Out of the box you get:

- [Zurb Foundation 5](http://foundation.zurb.com)
- [Font Awesome 4.0.3](http://fortawesome.github.io/Font-Awesome/)
- A blog! Including feeds, archives, tags, etc…
- [Multimarkdown](http://fletcherpenney.net/multimarkdown/) support.
- [Disqus](http://disqus.com/);
- Classic and Universal [Google Analytics](https://developers.google.com/analytics/devguides/collection/analyticsjs/);
- [MathJax](http://www.mathjax.org/).
- Syntax highlighting with [Coderay](http://coderay.rubychan.de) or [highlight.js](http://highlightjs.org).
- Helper functions for placeholder text and images (see `lib/helpers/lorem.rb`).


## Requirements

- Ruby (tested with Ruby 2.x).
- [Bower](http://bower.io/).
- [Multimarkdown](http://fletcherpenney.net/multimarkdown/) (optional).

## Installation and upgrade

First, install [Bundler](http://bundler.io/) if you haven't done so already:

    gem install bundler

To install this project, clone the repository, then

    cd nanoc-by-lifepillar
    bundle install
    bower install

The project is self-contained: the commands above will not install anything
outside the project's folder.

To build and view your site:

    bundle exec nanoc compile
    bundle exec nanoc view

To build a production version of your site, delete the `tmp` folder and type:

    NANOC_ENV=production bundle exec nanoc compile

To update Zurb Foundation:

    bower update

To update [Font Awesome](http://fortawesome.github.io/Font-Awesome/),
download the latest release and drop it inside the `static` folder
(only the `fonts` and `scss` folders are needed), replacing the existing
`font-awesome` folder.


## Usage and customization

First of all, edit the site's metadata at the bottom of `nanoc.yaml`.
Such metadata consist of the site's title, slogan, author, etc…, menu data,
and other information.
For example, to add a link to the main menu, just add a title/link pair to the
`menu` item in `nanoc.yaml`.

Then, you should edit or replace `content/index.erb`. You may also want to
remove `content/blog/posts/examples`. You can delete the whole `content/blog`
folder if you do not need a blog.

In the frontmatter of any item, you may use the variables `head`, `beginbody`,
and `endbody` to load additional partials, just before the `</head>` tag, just
after `<body>`, and just before `</body>`, respectively. For example, for a page
that includes MathJax, Disqus comments and Google Analytics, your frontmatter
might look like this:

    ---
    title: My Page
    head: [mathjax]
    endbody: [disqus, analytics]
    ---

Each variable takes a list of names of partials, which must exist inside
`layouts/partials`. You may use your own partials in the same way. Of course,
for a bunch of pages having the same structure, it is better to define a custom
layout.

There is also a command to simplify the creation of a blog post:

    nanoc create-post Title of my wonderful post

By default, it creates a file with `.mmd` suffix (MultiMarkdown).
Pass `-m` if you want just a Markdown file (with `.md` suffix).
