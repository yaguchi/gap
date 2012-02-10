namespace :hg do
  task :fetch do
    pull
    update
  end

  task :pull do
    run "cd #{deploy_to} && hg pull -b #{env}" 
  end

  task :update do
    run "cd #{deploy_to} && hg update #{env} -C" 
    glog
  end

  task :id do
    run "cd #{deploy_to} && hg id" 
  end

  task :glog do
    run "cd #{deploy_to} && hg glog | head -n 40" 
  end

  task :commit do
    run "cd #{deploy_to} && hg commit -A -m 'auto commit'" 
  end
end
