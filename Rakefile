# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "rubygems"
require 'bundler'
Bundler.require
require 'bubble-wrap'
require 'motion-support/core_ext/hash'
require 'bubble-wrap/location'

Motion::Project::App.setup do |app|
  app.name = 'PeakBadger'
  app.frameworks += ['CoreLocation']
  app.detect_dependencies = false
end
