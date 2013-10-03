# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
Bundler.require

require 'under-os'

Motion::Project::App.setup do |app|
  app.name       = 'uos-demo'
  app.identifier = 'com.under-os.demo'
  app.specs_dir  = './spec/lib'
  app.version    = UnderOs::VERSION

  app.codesign_certificate = ENV['RUBYMOTION_CERTIFICATE']
  app.provisioning_profile = ENV['RUBYMOTION_PROFILE']

  if ARGV[0] == 'spec'
    app.name       = 'uos-spec'
    app.identifier = 'com.under-os.spec'
    app.files << 'spec/assets/test_page.rb'
    app.resources_dirs.unshift "./spec/assets/"
  end
end
