# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'bundler'
Bundler.require
require 'motion-support/core_ext/hash'
require 'bubble-wrap/location'
require 'bubble-wrap/reactor'
require 'json'

TF_API_TOKEN = '725c8167626fdb2588e57673d782d2f8_MTg4NTM2NzIwMTQtMDUtMzEgMjA6MDY6MjQuMTcyNjEw'
TF_TEAM_TOKEN = '2a61c9c52c1aa18af57c86f94d5df611_Mzg3Njg0MjAxNC0wNS0zMSAyMDowOTozMS41MDY1ODM'
TF_APP_TOKEN = '26a74803-c63e-40a3-8c72-f0f80eb7ca8a'

Motion::Project::App.setup do |app|
  app.name = 'PeakBadger'
  app.frameworks += ['CoreLocation']
  app.detect_dependencies = false
  app.pixatefreestyle.framework = 'vendor/PixateFreestyle.framework'
  app.interface_orientations = [:portrait]
end

desc 'upload to testflight'
task :testflight => ['compile:data', 'pixatefreestyle:sass', 'archive'] do
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

namespace :compile do
  desc 'compile data'
  task :data do
    peak_files = Dir.glob(File.join File.dirname(__FILE__), 'data', 'peaks', '**', '*.geojson')
    raw_peaks_json = peak_files.each_with_object([]) do |file, ary|
      ary << JSON.load(File.read file) unless File.basename(file) =~ /^_index/
    end
    File.open('./resources/data/peaks.json', 'w+') { |f| f.write JSON.dump raw_peaks_json }
  end
end

Rake::Task['simulator'].enhance ['pixatefreestyle:sass', 'compile:data']
