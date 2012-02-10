load File.expand_path './recipes/hg.rb', File.dirname(__FILE__)
load File.expand_path './recipes/sys.rb', File.dirname(__FILE__)

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_bin_path, "/usr/local/rvm/bin/"

set :stages, %w(dev alpha beta pro)
set :default_stage, "dev"
set :scm, "mercurial"
set :env, ARGV[0]
set :branch, env

set :deploy_to, "/var/apps/#{env}/#{fetch :application}"
#set :pid_file,  "#{deploy_to}/pid/#{env}.pid"
set :use_sudo, true
