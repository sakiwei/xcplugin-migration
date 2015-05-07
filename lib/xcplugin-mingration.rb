$:.unshift(File.expand_path("../", __FILE__))
require "xcplugin-mingration/version"

module XcpluginMingration
  autoload :CLI, 'xcplugin-mingration/cli'
end