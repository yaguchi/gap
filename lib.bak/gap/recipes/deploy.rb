namespace :deploy do

  task :default do
    hg.fetch
    restart
  end

  task :setup do
    create_gemset if rvm_ruby_string 
    run "mkdir -p #{clone_to} && cd #{clone_to} && hg clone #{repository}"
  end
   
  task :create_gemset do
    version,gemset = rvm_ruby_string.split("@")
    run "rvm gemset create #{gemset}"
  end
end
