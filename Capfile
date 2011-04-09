require 'rubygems'
load 'deploy'

set :scm, :git
set :application, "davidspattison" 
set :repository, 'git@github.com:dspattison/davidspattison.git'

set :deploy_via, :remote_cache #keep files locally and do an update

role :web, 'ec2-50-16-139-242.compute-1.amazonaws.com'
role :app, 'ec2-50-16-139-242.compute-1.amazonaws.com'

ssh_options[:user] = "ubuntu"
ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/davidp.pem"]

set :use_sudo, false 

namespace :deploy do
  
  task :restart do
    run "echo run this: sudo /etc/init.d/apache2 reload"
  end

  task :migrate do
    #disabled
  end
end
