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

          gap_config.each do |env,value|

            if env == "global"
              value["set"].each { |attr, val| set attr, val}
            else
              task(env) do
                define_bulk_tasks value
                define_config_tasks value
              end
            end

          end

        end
      end
    end
  end

end
