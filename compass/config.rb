# Require any additional compass plugins here.
add_import_path "bower_components/foundation/scss"

http_path            = "/"
project_path = File.expand_path(File.join(File.dirname(__FILE__), '..'))
css_dir              = "public/assets/stylesheets"  # compiled files
sass_dir             = "content/assets/stylesheets" # source files
fonts_dir            = "content/assets/fonts"
images_dir           = "content/assets/images"
javascripts_dir      = "content/assets/javascripts"
#http_javascripts_dir = "javascripts"
#http_stylesheets_dir = "stylesheets"
#http_images_dir      = "images"
#http_fonts_dir       = "fonts"

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
