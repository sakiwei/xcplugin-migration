$:.unshift(File.expand_path("../", __FILE__))
require "xcplugin-mingration/version"

module Xcplugin-mingration
  autoload :CLI, 'xcplugin-mingration/cli'
end