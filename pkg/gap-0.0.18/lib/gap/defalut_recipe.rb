set :stages, %w(dev alpha beta pro)
set :default_stage, "dev"
set :scm, "mercurial"
set :env, ARGV[0]
set :branch, env

set :clone_to, "/var/apps/#{env}"
set :deploy_to, "/var/apps/#{env}/#{fetch :application}"
#set :pid_file,  "#{deploy_to}/pid/#{env}.pid"
set :use_sudo, true

load File.expand_path './recipes/hg.rb', File.dirname(__FILE__)
load File.expand_path './recipes/sys.rb', File.dirname(__FILE__)
load File.expand_path './recipes/god.rb', File.dirname(__FILE__)
#load 'deploy' if respond_to?(:namespace)
load File.expand_path './recipes/deploy.rb', File.dirname(__FILE__)

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_bin_path, "/usr/local/rvm/bin/"
