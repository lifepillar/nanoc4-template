# Nanoc 4 Template

This is a starting point for a web site built with [Nanoc 4](http://nanoc.ws/).

Features:

- extends Nanoc helpers and provides templates to fully support blogs! Including
  feeds, archives, tags, etc…
- works with [Compass](http://compass-style.org) out of the box;
- builds development/production version of your site;
- aggregates JavaScript and CSS files, and minifies JavaScript, CSS and HTML;
- includes [Font Awesome](http://fontawesome.io) Sass files by default.
- provides helper functions for placeholder text and images;
- adds syntax highlighting using [Pygments](http://pygments.org).

With this template, you may:

- choose between [Zurb Foundation](http://foundation.zurb.com) and [Bootstrap
  Sass](https://github.com/twbs/bootstrap-sass) (or use your own framework or no
  framework at all);
- write your posts in Markdown or
  [Multimarkdown](http://fletcherpenney.net/multimarkdown/);
- easily add [Google
  Analytics](https://developers.google.com/analytics/devguides/collection/analyticsjs/),
  [Disqus](http://disqus.com/), [MathJax](http://www.mathjax.org/) and user
  defined snippets to a page by editing a page's frontmatter;
- deploy via Git to Github Pages or other hosts.

Take a look at the [sample
content](http://lifepillar.github.io/nanoc4-template/) that comes with this
template.


## Requirements

- Nanoc 4.0.0rc2 or later.
- [Bundler](http://bundler.io/).
- [Bower](http://bower.io/).

Optional, but recommended:

- [Multimarkdown](http://fletcherpenney.net/multimarkdown/).
- [HtmlCompressor](https://code.google.com/p/htmlcompressor/).

Bower is used to install libraries and frameworks (jQuery, Foundation,
Bootstrap, Font Awesome, …) into `content/assets/components`. You may use any
other method (including dropping folders manually or using a CDN): Bower is not
really essential to use this template. If you don't use Bower, you may delete
`bower.json` and `.bowerrc`.


## Quickstart

    git clone git://github.com/lifepillar/nanoc4-template
    cd nanoc4-template
    bundle install
    bower install
    bundle exec nanoc
    bundle exec nanoc view

Point your browser to `http://localhost:3000`.


## Customization

Modify the site's metadata and deployment settings in `nanoc.yaml`. Edit or
replace `content/index.erb`. You may also want to remove
`content/blog/posts/examples`. You may delete the whole `content/blog` and
`layouts/blog` folders if you do not need a blog. You should also change the
favicon (`content/assets/images/favicon/png`).

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

You may put JavaScript scripts in `content/assets/scripts`. If you want to
aggregate scripts, include them in `content/assets/scripts/all.js.erb` using
`File.read`. You may put (S)CSS files in `content/assets/stylesheets`. To
aggregate (S)CSS files, import them in `content/assets/stylesheets/main.scss`.

[Compass](http://compass-style.org) configuration is in `compass_config.rb`. If
you don't use Compass, feel free to delete `compass_config.rb` and `lib/compass.rb`.

To build a production version of your site, delete the `tmp` folder and set the
`NANOC_ENV` environment variable:

    NANOC_ENV=production bundle exec nanoc


### Using Foundation

By default, this template uses [Zurb Foundation](http://foundation.zurb.com).
You may override Foundation's default settings by editing
`assets/stylesheets/foundation/_foundation_overrides.scss`. You may choose which
Foundation components to use in `_app.scss`. You may put your own styles in
`_custom.scss`.


### Using Bootstrap

If you want to use [Bootstrap](http://getbootstrap.com) instead, edit
`main.scss`, comment out the line

    @import "foundation/app";

and uncomment

    @import "bootstrap/styles";

Then, edit `content/assets/scripts/all.js.erb` and replace

    <%= File.read('content/assets/components/foundation/js/foundation.js') %>
    $(document).foundation();

with

    <%= File.read('content/assets/components/bootstrap-sass/assets/javascripts/bootstrap.js') %>

You may override Bootstrap variables and choose which Bootstrap components to
use by modifying the corresponding files in
`content/assets/stylesheets/bootstrap`. You may define your own styles in
`content/assets/stylesheets/bootstrap/_custom.scss`.


### How to deploy to Github Pages

These instructions assume that you have created a `gh-pages` branch in your repo
on Github as per Github documentation.

**Note:** in order for links to work properly on Github pages, you may need to apply
Nanoc's `:relativize_paths` filter to the generated content.

#### Setup

The following steps must be executed every time you purge and/or delete the
`public` folder:

1. Build your web site at least once to create the `public` folder.

2. Initialize a Git repo in the `public` folder:

        cd public && git init

3. Set the origin of the public repo to point to your remote repository on Github:

        git remote add origin <URI>

   Note that this origin is totally independent of the origin of your project's repo
   (it may be the same or be different).

4. Create a local `gh-pages` branch in the public repo:

        git checkout -b gh-pages

5. Create at least one commit in the public repo:

        git add -A
        git commit "Initial commit."


#### Publishing

The following commands must be executed in your project's root folder every time
you want to deploy a new version of your site:

1. Remove the `tmp` folder (optional but recommended):

        rm -fr tmp

2. Build a production version of your site:

        NANOC_ENV=production bundle exec nanoc

3. (Optional, but recommended) Preview your site and perform checks:

        bundle exec nanoc view
        bundle exec nanoc check --all

4. Deploy to Github pages (this assumes the default configuration of this
  template):

        bundle exec nanoc deploy -n
        bundle exec nanoc deploy


### Placeholder content

The file `lib/helpers/lorem.rb` contains a few functions to put placeholder text
and images for quick prototyping. For example:

- `Lorem.paragraphs(n)`: generates `n` paragraphs of random text.
- `Lorem.sentences(n)`: generates a string consisting of `n` random sentences.
- `Lorem.words(n)`: generates a string of `n` random words.
- `Lorem.image(size, options)`: generates a placeholder image, by default using
  [placehold.it](http://www.placehold.it).

Refer to the source code for a complete list and to the sample code for some
examples of usage.

