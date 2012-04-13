require 'yaml'
require 'gap/god_erb'
require 'gap/tasks'
require 'gap/sudo_run'


module Capistrano
  class CLI
    module Execute
      def execute!
        config = instantiate_configuration(options)
        config.debug = options[:debug]
        config.dry_run = options[:dry_run]
        config.preserve_roles = options[:preserve_roles]
        config.logger.level = options[:verbose]

        set_pre_vars(config)
        load_recipes(config)

        load_gap_yml(config)
        load_gap_default_recipe(config)

        config.trigger(:load)
        execute_requested_actions(config)
        config.trigger(:exit)

        config
      rescue Exception => error
        handle_error(error)
      end 

      def load_gap_default_recipe config

        config.load { load File.expand_path './defalut_recipe.rb', File.dirname(__FILE__)}
      end


      def load_gap_yml config
        #コマンドラインオプションにする
        gap_config = YAML.load_file("config/gap.yml")
        config.send(:extend,Gap::Tasks)
        config.send(:extend,Gap::SudoRun)
        config.load do
          config.init_val

          gap_config.each do |env,value|

            variables = value["set"]
            case env
            when "global"
              variables.each { |attr, val| set attr, val} if variables
            when "local"
              task(env) do
                define_bulk_tasks value
                variables.each { |attr, val| set attr, val } if variables
                value.each do |app, commands|
                  task(app) do
                    commands["task"].each { |name, command|
                      task(name) { system("rvm-shell '#{rvm_ruby_string}' -c '#{command}'")}}
                  end
                end
              end
            else
              task(env) do
                define_config_tasks value
                define_bulk_tasks value
              end
            end

          end

        end
      end
    end
  end

end
