# Nanoc + Zurb Foundation 5 + Font Awesome

This is a starting point for a web site built with [Nanoc](http://nanoc.ws/)
that includes support for [Zurb Foundation 5](http://foundation.zurb.com)
and [Font Awesome](http://fortawesome.github.io/Font-Awesome/).

To install, clone the repository, then

    cd nanoc-by-lifepillar
    bundle install
    bower install

To update Zurb Foundation:

    bower update

The project is self-contained: the commands above will not install anything
outside the project's folder.

To build and view your site:

    nanoc compile
    nanoc view

To build a production version of your site, delete the `tmp` folder and type:

    NANOC_ENV=production nanoc compile

To update [Font Awesome](http://fortawesome.github.io/Font-Awesome/),
download the latest release and put it inside the `static` folder
(only the `fonts` and `scss` folders are needed).


## Usage and customization

First of all, edit the site's metadata at the bottom of `nanoc.yaml`.
Such metadata consist of the site's title, slogan, author, etc…, and menu data.
For example, to add a link to the main menu, just add a title/link pair to the
`menu` item.

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
