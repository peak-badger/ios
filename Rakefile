# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'bundler'
Bundler.require
require 'motion-support/core_ext/hash'
require 'bubble-wrap/location'

TF_API_TOKEN = '725c8167626fdb2588e57673d782d2f8_MTg4NTM2NzIwMTQtMDUtMzEgMjA6MDY6MjQuMTcyNjEw'
TF_TEAM_TOKEN = '2a61c9c52c1aa18af57c86f94d5df611_Mzg3Njg0MjAxNC0wNS0zMSAyMDowOTozMS41MDY1ODM'
TF_APP_TOKEN = '26a74803-c63e-40a3-8c72-f0f80eb7ca8a'

Motion::Project::App.setup do |app|
  app.name = 'PeakBadger'
  app.frameworks += ['CoreLocation']
  app.detect_dependencies = false
  app.pixatefreestyle.framework = 'vendor/PixateFreestyle.framework'
  app.interface_orientations = [:portrait]

  # app.testflight.sdk = 'vendor/TestFlight'
  # app.testflight.api_token = '725c8167626fdb2588e57673d782d2f8_MTg4NTM2NzIwMTQtMDUtMzEgMjA6MDY6MjQuMTcyNjEw'
  # app.testflight.team_token = '2a61c9c52c1aa18af57c86f94d5df611_Mzg3Njg0MjAxNC0wNS0zMSAyMDowOTozMS41MDY1ODM'
  # app.testflight.app_token = '26a74803-c63e-40a3-8c72-f0f80eb7ca8a'
  # app.testflight.distribution_lists = ['badgers']
  # app.testflight.notify = true # default is false
  # app.testflight.identify_testers = true # default is false

  app.pods do
    pod 'NSData+MD5Digest'
  end
end

desc 'upload to testflight'
task :testflight => ['pixatefreestyle:sass', 'archive'] do
  file = Dir['./build/iPhoneOS-*/*.ipa'].first
  cmd = [
      "curl http://testflightapp.com/api/builds.json",
      "-F file=@#{file}",
      "-F api_token='#{TF_API_TOKEN}'",
      "-F team_token='#{TF_TEAM_TOKEN}'",
      "-F notes='This build was uploaded via the upload API'",
      "-F notify=True",
      "-F distribution_lists='badgers'"
  ].join(' ')
  puts cmd
  system cmd
end

