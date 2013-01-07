# -*- coding: utf-8 -*-

$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

# ENV['retina'] = '3.5' # launch the retina simulator by default

require 'rubygems'
require 'ib'
require 'motion_data'

Motion::Project::App.setup do |app|

  # Use `rake config' to see complete project settings.
  app.name = 'Lectronimo'
  app.delegate_class = 'App'

  app.frameworks += ['QuartzCore', 'CoreImage', 'CoreData']

  app.codesign_certificate = 'iPhone Developer: Gino Lucero (ZT8S25LX7N)'
  app.identifier = 'com.glucero.Lectronimo'
  app.provisioning_profile = 'Lectronimo_Dev.mobileprovision'

  # app.deployment_target = '5.1' # change iOS version support

end
