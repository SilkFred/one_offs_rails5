require 'one_offs/runner'

namespace :one_offs do
  desc "Create a one off script"
  task :create_one_off do
    # Get command line arguments
    ARGV.each { |a| task a.to_sym do ; end }

    # Get all existing one-off file names
    one_off_files = Dir.glob("#{Rails.root}/lib/one_offs/**/*").map { |file| file.split('/')[-1] }

    # Calculate increment for new file name
    increment = one_off_files.any? ? one_off_files.sort.last.scan(/[0-9\(\)]+/)[0].to_i + 1 : 1

    directory = Rails.root.join('lib', 'one_offs')
    filename = ARGV[1].singularize

    File.open("#{directory}/#{increment}_#{filename}.rb", "w") do |file|
      contents = "class #{filename.classify.to_s}\n"\
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
