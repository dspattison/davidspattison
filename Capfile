require 'rubygems'
load 'deploy'

set :deploy_time, `date`.chomp!
set :deploy_user, `whoami`.chomp!


set :scm, :git
set :application, "davidspattison" 
#set :repository, 'git@github.com:dspattison/davidspattison.git'
set :repository, 'git@git.davidspattison.com:davidspattison.git'

#set :deploy_via, :remote_cache #keep files locally and do an update

role :web, 'ec2-50-16-139-242.compute-1.amazonaws.com'
role :app, 'ec2-50-16-139-242.compute-1.amazonaws.com'

ssh_options[:user] = "ubuntu"
ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/davidp.pem"]

set :use_sudo, false 

namespace :deploy do
  
  task :default do
    update_code
    render_keel
    symlink
  end
  
  task :restart do
    run "echo run this: sudo /etc/init.d/apache2 reload"
  end

  task :migrate do
    #disabled
  end
  
  task :render_keel do 
    run "echo '<center>Updated on #{deploy_time} by #{deploy_user}</center>' >> #{release_path}/app/views/shared/_keel.html.erb"
  end
end
