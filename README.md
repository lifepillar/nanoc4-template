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

To update [Font Awesome](http://fortawesome.github.io/Font-Awesome/),
download the latest release and put it inside the `static` folder
(only the `fonts` and `scss` folders are needed).
