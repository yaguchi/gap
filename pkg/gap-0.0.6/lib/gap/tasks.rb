module Gap
  module Tasks
    def define_bulk_tasks value
      #gap dev start,restart,god
      %w(start reload).each do |com|
        task(com) do
          value["task"].each do |app, commands|
            send(app)
            send(com) if commands[com]
          end
        end
      end

      task(:stop) do
        value["task"].reverse.each do |app, commands|
          send(app)
          send(commands["stop"])
        end
      end

      task(:restart) do
        stop
        start
      end

      task(:god) do
        value["task"].each do |app,commands|
          send(app)
          send(:god)
        end
      end
    end

    def define_config_tasks value
      value["role"].each { |attr, val| role attr.to_sym, val }
      #value["set"].each { |attr, val| set attr, val }
      value["task"].each do |app, commands|

        if value["god"]
          task(app) do
            task(:god) do
              god_config_path = File.join( deploy_to, "config/god_#{application}_#{app}.rb")
              god_config = Gap::GodErb.new("./gap/tmpl.erb",application, app, commands)
              upload( god_config.render, god_config_path, :via => :scp)
              sudo "god load #{god_config_path}"
            end

            commands.each do |name, command|
              task(name) do
                sudo "god #{name} #{app}_#{application}"
              end
            end
          end
        else

          task(app) do
            commands.each { |name, command|
              task(name) { sudo_run command }}
          end

        end
      end
    end
  end
end
