# Nanoc by Lifepillar

This is a starting point for a web site built with [Nanoc](http://nanoc.ws/).
Out of the box you get:

- The latest [Zurb Foundation](http://foundation.zurb.com);
- [Font Awesome](http://fontawesome.io);
- a blog! Including feeds, archives, tags, etc…
- [Multimarkdown](http://fletcherpenney.net/multimarkdown/) support (and Markdown, too!);
- [Disqus](http://disqus.com/);
- Classic and Universal [Google Analytics](https://developers.google.com/analytics/devguides/collection/analyticsjs/);
- [MathJax](http://www.mathjax.org/);
- syntax highlighting with [Pygments](http://pygments.org);
- helper functions for placeholder text and images (see `lib/helpers/lorem.rb`);
- aggregated JavaScript and CSS;
- publishing your site via Git to Github Pages or other hosts;
- the great flexibility that nanoc offers.

Take a look at the [sample content](http://lifepillar.github.io/nanoc-by-lifepillar/)
that comes with this template.


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

To build and view your site:

    bundle exec nanoc
    bundle exec nanoc view

To build a production version of your site, delete the `tmp` folder and type:

    NANOC_ENV=production bundle exec nanoc

To update Zurb Foundation:

    bower update

To update [Font Awesome](http://fontawesome.io), edit `layouts/default.erb`
and update the link to Font Awesome's CDN.


## Usage and customization

First of all, edit the site's metadata at the bottom of `nanoc.yaml`.
Such metadata consist of the site's title, slogan, author, etc…, menu data,
and other information.
For example, to add a link to the main menu, just add a title/link pair to the
`menu` item in `nanoc.yaml`.

Then, you should edit or replace `content/index.erb`. You may also want to
remove `content/blog/posts/examples`. You may delete the whole `content/blog`
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

You may require additional JavaScripts in `content/assets/javascripts/all.js`
and import additional (S)CSS files in `content/assets/stylesheets/main.scss`.
[Compass](http://compass-style.org) configuration is in
`compass_config.rb`.

There is a custom command to simplify the creation of a blog post:

    nanoc create-post Title of my wonderful post

By default, this command creates a Markdown file
in the `content/blog/posts` folder.
Pass `-M` if you want a MultiMarkdown file.

Finally, this template uses the [nanoc-external](https://github.com/nanoc/nanoc-external) filter,
which allows you to pass content to
an external program. Such program must be able to read its input from STDIN and
send its output to STDOUT. For example, if you have installed
[htmlcompressor](https://code.google.com/p/htmlcompressor/), you can have your
pages minified by adding a filter rule similar to the following:

    filter :external,
      :exec => 'htmlcompressor',
      :options => %w( --compress-css )


## Customize Font Awesome

If, for some reason, you need to customize Font Awesome, do the following:

- remove the link to Font Awesome in the `<head>` section of `layouts/default.erb`;
- create a `static` folder in the project root;
- download the latest Font Awesome release and drop it into the `static` folder
  (only the `fonts` and `scss` folders are needed);
- Uncomment the `@import` line at the bottom of `content/assets/stylesheets/main.scss`;
- Uncomment the `add_import_path` line at the top of `compass_config.rb`.

Compile your site again and you are ready to go!


## Publishing

The template is configured to publish your site on Github pages using the command:

    nanoc deploy

You may change the remote and the branch from `origin` and `gh-pages`, respectively,
to something else (`remote` can be the name or the URI of a repository).
