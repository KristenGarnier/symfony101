set :application, "Capifony vagrant test"
set :domain,      "10.10.10.10"
set :user,        "vagrant"
set :use_sudo, false
set :deploy_to,   "/var/www/awesome"
set :app_path,    "app"
set :web_path, 	  "web"

set :repository,  "https://github.com/KristenGarnier/symfony101.git"
set :scm,         :git

set :model_manager, "doctrine"


role :web,        domain                         # Your HTTP server, Apache/etc
role :app,        domain, :primary => true       # This may be the same as your `Web` server
role :db,         domain, :primary => true

set :writable_dirs,   ["app/cache", "app/logs"]
set :webserver_user,      "www-data"
set :permission_method,   :acl
set :use_set_permissions, true

ssh_options[:forward_agent] = true

set :user_composer, true
set :update_verdors, true


ssh_options[:forward_agent] = true
#ssh_options[:keys] = %w(C:\vagrant\BzSWvb\puphpet\files\dot\ssh\id_rsa.ppk)

set  :keep_releases,  3

task :upload_parameters do
  origin_file = "app/config/parameters.yml"
  destination_file = shared_path + "/app/config/parameters.yml" # Notice the
  shared_path

  try_sudo "mkdir -p #{File.dirname(destination_file)}"
  top.upload(origin_file, destination_file)
end

after "deploy:setup", "upload_parameters"

default_run_options[:pty] = true

set :shared_files, ["app/config/parameters.yml"]
set :shared_children,     [app_path + "/logs", web_path + "/uploads", "vendor"]


logger.level = Logger::MAX_LEVEL