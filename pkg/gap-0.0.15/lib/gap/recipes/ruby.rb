namespace :ruby do
  task :bundle_install do
    run "source /etc/bashrc && cd #{deploy_to} && sudo bundle install" 
  end

  task :migrate do
    run "source /etc/bashrc && cd #{deploy_to} && RAILS_ENV=#{env} bundle exec rake db:migrate" 
  end

  task :log do
    run "tail -f #{deploy_to}/log/production.log" do |channel, stream, data|
      puts  # for an extra line break before the host name
      puts "#{channel[:host]}: #{data}" 
      break if stream == :err    
    end
  end

end
