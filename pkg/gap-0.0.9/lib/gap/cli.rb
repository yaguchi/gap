require 'capistrano/cli'
require 'gap/patch'

module Gap
  class CLI
    def self.execute
      Capistrano::CLI.execute
    end
  end
end

