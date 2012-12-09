load 'deploy/assets'
require 'bundler/capistrano'

set :application, "thewendyhouseradlett.co.uk" # this will be used to create the folder structure (see line)
set :user, 'deploy'
set :rails_env, "production"
set :scm, 'git'
set :repository,  "git@github.com:geoffw8/nursery.git"
set :branch, 'master'
set :scm_verbose, true
set :keep_releases, 3
set :use_sudo, true

set :domain, '176.58.99.10'
set :applicationdir, "/var/www/sites/#{application}"

set :default_environment, { 
  'PATH' => "/usr/local/rvm/gems/ruby-1.9.3-p327/bin:/usr/local/rvm/gems/ruby-1.9.3-p327@nursery/bin:/usr/local/rvm/rubies/ruby-1.9.3-p327/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
  'RUBY_VERSION' => 'ruby 1.9.3p327',
  'GEM_HOME' => '/usr/local/rvm/gems/ruby-1.9.3-p327',
  'GEM_PATH' => '/usr/local/rvm/gems/ruby-1.9.3-p327:/usr/local/rvm/gems/ruby-1.9.3-p327@nursery' 
}

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :remote_cache

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/home/user/.ssh/id_rsa)            # If you are using ssh_keysset :chmod755, "app config db lib public vendor script script/* public/disp*"set :use_sudo, false

# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

#  task :link_db do
#    run "#{try_sudo} cp /var/www/sites/weartolook.com/shared/config/database.yml /var/www/sites/weartolook.com/current/config/database.yml"
#  end
end

after "deploy:update", "deploy:cleanup" 