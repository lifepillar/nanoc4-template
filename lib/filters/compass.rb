class CompassFilter < Nanoc::Filter
   identifier :compass

   requires 'compass'

   def run(content, params = {})
     Compass.add_project_configuration(params.fetch(:config_file))
     params = params.merge(Compass.sass_engine_options)

     Nanoc::Filters::Sass.new(@assigns).setup_and_run(content, params)
   end
 end
