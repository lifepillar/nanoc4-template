require 'compass/import-once/activate'
# Require any additional compass plugins here.
add_import_path "bower_components/foundation/scss"
add_import_path "bower_components/bootstrap-sass/assets/stylesheets"
add_import_path "bower_components/fontawesome/scss"

http_path             = "/"
project_path          = File.expand_path(File.dirname(__FILE__))
css_dir               = "public/css"  # compiled files
sass_dir              = "content/assets/stylesheets" # source files
fonts_dir             = "content/assets/fonts"
images_dir            = "content/assets/images"
javascripts_dir       = "content/assets/javascripts"
http_javascripts_path = "javascripts"
http_stylesheets_path = "css"
http_images_path      = "images"
http_fonts_dir        = "fonts"

# when using SCSS:
sass_options = {
  :syntax => :scss
}

if ENV['NANOC_ENV'] == 'production'
  output_style = :compressed # :expanded or :nested or :compact or :compressed
else
  output_style = :expanded
end

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

