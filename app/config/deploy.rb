set :application, "Capifony vagrant test"
set :domain,      "dev1.fast-order.fr"
set :user,        "fastorderuser"
set :use_sudo, false
set :deploy_to,   "sd/dev1/www/test"
set :app_path,    "app"
set :web_path, 	  "web"

set :repository,  "C:/xampp/htdocs/symfony101"
set :deploy_via,  :copy
set :scm,         :git

set :model_manager, "doctrine"


role :web,        domain                         # Your HTTP server, Apache/etc
role :app,        domain, :primary => true       # This may be the same as your `Web` server
role :db,         domain, :primary => true

set :writable_dirs,   ["app/cache", "app/logs"]
ssh_options[:forward_agent] = true

#set :user_composer, true
#set :update_verdors, true

set :composer_install_flags, '--no-dev --no-interaction --optimize-autoloader'


ssh_options[:forward_agent] = true
ssh_options[:keys] = %w(C:/ssh/ssh_fastfood_private)

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