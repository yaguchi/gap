module Gap
  module Tasks

    def init_val
      set :rvm_ruby_string, nil
      set :god_config_path, nil
    end

    def define_bulk_tasks value
      return unless value
      #gap dev start,restart,god
      %w(role set task).each {|key| value.delete(key)}
      %w(start stop reload restart).each do |com|
        task(com) do
          value.to_a.each do |app, commands|
            send(app)
            send(com) if commands["task"][com]
          end
        end
      end

      namespace :god do
        task(:config) do
          value.each do |app,commands|
            send(app)
            send(:config)
          end
        end
      end
    end

    def define_config_tasks value
      return unless value
      
      value.each do |attr,val|

        case attr
        when "role"
          val.each { |attr, val| role attr.to_sym, val } if val
        when "set"
          val.each { |attr, val| set attr, val } if val
        else

          val.each do |a, v|
            case a
            when "role"
              v.each { |attr, val| role attr.to_sym, val } if v
            when "set"
              v.each { |attr, val| set attr, val } if v
            when "task"
              if fetch :god

                task(attr) do
                  namespace :god do
                    task(:config) do
                      god_config_path = File.join( deploy_to, "config/god_#{application}_#{attr}.rb")
                      tmpl_path = File.expand_path 'tmpl.erb', File.dirname(__FILE__) 
                      god_config = Gap::GodErb.new(tmpl_path,application, attr, v.merge({"pid_file" => pid_file}))
                      upload( god_config.render, god_config_path, :via => :scp)
                      sudo "rvm-shell '#{rvm_god_string}' -c 'god load #{god_config_path}'"
                    end
                  end

                  v.each do |name, command|
                    if ["start","stop","restart"].include?(name)
                      task(name) do
                        sudo "rvm-shell '#{rvm_god_string}' -c 'god #{name} #{attr}_#{application}'"
                      end
                    else
                      task(name) do
                        sudo_run command 
                      end
                    end
                  end
                end
              else
                task(attr) do
                  v.each do |name, command|
                    task(name) { sudo_run command }
                  end
                end
              end
            else
            end
          end
        end
      end
    end

  end
end
