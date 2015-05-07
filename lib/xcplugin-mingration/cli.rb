require 'thor'
require 'colorize'
require 'cfpropertylist'
require 'Pathname'

module XcpluginMingration

  XCODE_PLUGIN_DIRECTORY = "~/Library/Application Support/Developer/Shared/Xcode/Plug-ins"

  class CLI < Thor
    
    default_task :migrate

    desc 'migrate', 'Migrate XCPlugin to the latest Xcode'
    def migrate

      compatibility_UUID = xcode_plugin_compatibility_UUID
      puts "\nLatest XCode plugin compatibility UUID is '" + compatibility_UUID + "'."

      Dir.glob(File.join(File.expand_path(XCODE_PLUGIN_DIRECTORY), '*.xcplugin')).each { |f| 
        
        Dir.glob(File.join(f, 'Contents/info.plist')).each { |info_plist_path| 
          plugin_name = Pathname.new(f).basename.to_s
          puts "\nProcessing... [ ".uncolorize + plugin_name.blue.underline + " ]\n".uncolorize

          plist = CFPropertyList::List.new(:file => info_plist_path)
          data = CFPropertyList.native_types(plist.value)
          uuids = data["DVTPlugInCompatibilityUUIDs"].dup

          # check if uuids contain 
          unless uuids.include? compatibility_UUID

            uuids << compatibility_UUID

            data["DVTPlugInCompatibilityUUIDs"] = uuids

            plist = CFPropertyList::List.new

            plist.value = CFPropertyList.guess(data)

            plist.save(info_plist_path, CFPropertyList::List::FORMAT_XML)

            puts " > Xcode plugin compatibility UUID is added successfully.".green

          else 
            puts " > Xcode plugin compatibility UUID has been already added.".uncolorize
          end

        }
      }

      puts "\n=== Migration Finished ===\n".yellow

    end

    no_tasks do
      
      # get the latest xcode compatibility uuid
      def xcode_plugin_compatibility_UUID
        `defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID`.gsub(/[\s\n]+/,'')
      end

    end

  end
end