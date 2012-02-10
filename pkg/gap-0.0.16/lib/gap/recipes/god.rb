namespace :god do
  task :setup do
    install
    start
  end
  task :install do
    version,gemset = rvm_god_string.split("@")
    sudo "rvm-shell '#{version}' -c 'rvm gemset create #{gemset}'"
    sudo "rvm-shell '#{rvm_god_string}' -c 'gem install god --no-ri --no-rdoc'"
    sudo "rvm-shell '#{rvm_god_string}' -c 'gem install activeresource -v 3.0.6 --no-ri --no-rdoc'"
    sudo "rvm-shell '#{rvm_god_string}' -c 'gem install tlsmail --no-ri --no-rdoc'"
  end

  task :start do
    if god_config_path
      sudo "rvm-shell '#{rvm_god_string}' -c 'god -c #{File.join(god_config_path)} --log-level info'"
    else
      sudo "rvm-shell '#{rvm_god_string}' -c 'god --log-level info'"
    end
  end

  task :quit do
    sudo "god quit"
  end

end
