require 'one_offs/runner'

namespace :one_offs do
  task create: [:create_one_off]

  desc "Create a one off script"
  task :create_one_off do
    # Get command line arguments
    ARGV.each { |a| task a.to_sym do ; end }

    directory = Rails.root.join('lib', 'one_offs')
    filename = ARGV[1]
    time = Time.now.to_i

    File.open("#{directory}/#{time}_#{filename}.rb", "w") do |file|
      contents = "class #{filename.camelize}\n"\
                 "  def self.process\n"\
                 "    # Enter your migration code here....\n"\
                 "  end\n"\
                 "end"

      file.puts(contents)
    end

    spec_directory = Rails.root.join('spec', 'lib', 'one_offs')

    File.open("#{spec_directory}/#{time}_#{filename}_spec.rb", "w") do |file|
      contents = <<~CONTENT
      require 'one_offs/#{time}_#{filename}'

      RSpec.describe #{filename.camelize} do
        before { described_class.process }

        it 'CHANGEME' do
          expect(1).to eq(2)
        end
      end
      CONTENT
      file.puts(contents)
    end

    puts "Created \e[32m lib/one_offs/#{time}_#{filename}.rb \e[0m"
    puts "Created \e[32m spec/lib/one_offs/#{time}_#{filename}_spec.rb \e[0m"
  end

  desc "Run all the one-off scripts"
  task :run => :environment do
    OneOffs::Runner.run
  end
end
