# Nanoc 4 Template

This is a starting point for a web site built with [Nanoc 4](http://nanoc.ws/).

Features:

- extends Nanoc helpers and provides templates to **fully support blogs**,
  including feeds, archives, tags, etc…
- works with [Compass](http://compass-style.org) out of the box;
- builds development/production version of your site;
- aggregates JavaScript and CSS files, and minifies JavaScript, CSS and HTML;
- provides helper functions for placeholder text and images;
- adds syntax highlighting using [Pygments](http://pygments.org);
- web framework agnostic (use it with [Zurb Foundation](http://foundation.zurb.com),
  [Bootstrap](http://getbootstrap.com), etc…, or with no framework at all).

With this template, you may:

- write your posts in Markdown or
  [Multimarkdown](http://fletcherpenney.net/multimarkdown/);
- easily add [Google
  Analytics](https://developers.google.com/analytics/devguides/collection/analyticsjs/),
  [Disqus](http://disqus.com/), [MathJax](http://www.mathjax.org/) and user
  defined snippets to a page by editing a page's frontmatter;
- deploy via Git to Github Pages or other hosts.


## Requirements

- [Nanoc](http://nanoc) 4.0.0 or later.
- [Bundler](http://bundler.io/).

Optional:

- [Multimarkdown](http://fletcherpenney.net/multimarkdown/).


## Quickstart

    git clone git://github.com/lifepillar/nanoc4-template
    cd nanoc4-template
    bundle install
    bundle exec nanoc
    bundle exec nanoc view

Point your browser to `http://localhost:3000`.


## Customization

1. Edit the “Deployment” and “Site-specific metadata” sections in `nanoc.yaml`.
2. Edit or replace `content/index.erb`.
3. Delete `content/blog/posts/examples`. You may delete the whole `content/blog`
   and `layouts/blog` folders if you do not need a blog.
4. If you do not plan to use Compass, you may delete `compass_config.rb`. Do not
   forget to update the corresponding compilation rule in `Rules`, too (search
   for `filter :compass`).
5. Change the favicon (`content/assets/images/favicon.png`).
6. Put JavaScript scripts into `content/assets/scripts`. If you want to
   aggregate scripts, put them somewhere inside the `components` folder instead,
   and add their path to the array in `main.js.erb`.
7. Put (S)CSS files in `content/assets/stylesheets`. If you use Compass,
   additional paths to stylesheets may be added in `compass_config.rb`. Files
   whose name starts with an underscore are not copied to the output: you may
   import them in `main.scss` to get a single aggregated CSS file in the output.
8. Put additional components, libraries or frameworks into
   `content/assets/components`. Update `all.js.erb` and `main.scss` to include
   the necessary files.


## Editing content

The site's content goes into the `content` folder. Blog posts go anywhere
under `blog/posts`.

In the frontmatter of any item, you may use the variables `head`, `beginbody`,
and `endbody` to load additional partials, just before the `</head>` tag, just
after `<body>`, and just before `</body>`, respectively. For example, for a page
that includes MathJax, Disqus comments and Google Analytics, the frontmatter
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

The file `lib/helpers/lorem.rb` contains a few functions to put placeholder text
and images for quick prototyping. For example:

- `Lorem.paragraphs(n)`: generates `n` paragraphs of random text.
- `Lorem.sentences(n)`: generates a string consisting of `n` random sentences.
- `Lorem.words(n)`: generates a string of `n` random words.
- `Lorem.image(size, options)`: generates a placeholder image, by default using
  [placehold.it](http://www.placehold.it).

Refer to the source code for a complete list and to the sample code for some
examples of usage.


## Deploying your site

To build a production version of your site, delete the `tmp` folder and set the
`NANOC_ENV` environment variable:

    NANOC_ENV=production bundle exec nanoc

This template is configured to deploy your site on GitHub Pages. See [Deploying
Nanoc sites](http://nanoc.ws/doc/deploying/) for the details.

**Note:** in order for links to work properly on Github pages, you may need to
apply Nanoc's `:relativize_paths` filter to the generated content.
