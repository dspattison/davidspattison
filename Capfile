require 'rubygems'
require 'erb'
load 'deploy'

set :deploy_time, `date`.chomp!
set :deploy_user, `whoami`.chomp!


set :scm, :git
set :application, "davidspattison" 
#set :repository, 'git@github.com:dspattison/davidspattison.git'
set :repository, 'git@git.davidspattison.com:davidspattison.git'

#set :deploy_via, :remote_cache #keep files locally and do an update

role :web, 'ec2-72-44-35-251.compute-1.amazonaws.com'
role :app, 'ec2-72-44-35-251.compute-1.amazonaws.com'

ssh_options[:user] = "ubuntu"

set :use_sudo, false 

namespace :deploy do
  
  task :default do
    update_code
    link_sqlite_db
    render_keel
    migrate
    symlink
    restart
  end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
   end
   
  task :link_sqlite_db, :roles => :app, :except => {:no_release => true} do
    run "ln -sf #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
  end

  task :migrate do
    #disabled
  end
  
  task :render_keel do 
    run "echo '<center>Updated on #{deploy_time} by #{deploy_user} #{`git ls-remote #{repository} HEAD|cut -b -40`.strip}</center> ' >> #{release_path}/app/views/shared/_keel.html.erb"
  end
end
