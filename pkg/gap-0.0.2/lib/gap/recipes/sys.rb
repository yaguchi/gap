namespace :sys do
  task :ps do
    run "ps alx | grep unicorn_zebra_beta.rb"
  end
end
