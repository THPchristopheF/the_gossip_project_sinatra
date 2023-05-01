require 'bundler'
Bundler.require

require './lib/controller'
$:.unshift File.expand_path("./../lib", __FILE__)
run ApplicationController  #execute le contenu de la class ApplicationController du fichier controller.rb