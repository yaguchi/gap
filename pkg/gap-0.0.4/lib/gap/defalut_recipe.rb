#load File.expand_path './recipes/hg.rb', File.dirname(__FILE__)
#load File.expand_path './recipes/sys.rb', File.dirname(__FILE__)
load 'gap/recipes/hg.rb'
load 'gap/recipes/sys.rb'

set :stages, %w(dev alpha beta pro)
set :default_stage, "dev"
set :scm, "mercurial"
set :env, ARGV[0]
set :branch, env

set :deploy_to, "/var/apps/#{env}/#{fetch :application}"
#set :pid_file,  "#{deploy_to}/pid/#{env}.pid"
set :use_sudo, true
