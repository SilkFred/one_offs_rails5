require 'one_offs/runner'

namespace :one_offs do
  desc "Create a one off script"
  task :create_one_off do
    # Get command line arguments
    ARGV.each { |a| task a.to_sym do ; end }

    directory = Rails.root.join('lib', 'one_offs')
    filename = ARGV[1]

    File.open("#{directory}/#{Time.now.to_i}_#{filename}.rb", "w") do |file|
      contents = "class #{filename.camelize}\n"\
                 "  def self.process\n"\
                 "    # Enter your migration code here....\n"\
                 "  end\n"\
                 "end"

      file.puts(contents)
    end
  end

  desc "Run all the one-off scripts"
  task :run => :environment do
    OneOffs::Runner.run
  end
end
