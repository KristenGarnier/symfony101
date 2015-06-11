set :application, "Capifony vagrant test"
set :domain,      "10.10.10.10"
set :user,        "vagrant"
set :use_sudo, false
set :deploy_to,   "/var/www/awesome"
set :app_path,    "app"

set :repository,  "file:C:\xampp\htdocs\symfony101"
set :deploy_via,   :copy
set :scm,         :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `subversion`, `mercurial`, `perforce`, or `none`

set :model_manager, "doctrine"
# Or: `propel`

role :web,        domain                         # Your HTTP server, Apache/etc
role :app,        domain, :primary => true       # This may be the same as your `Web` server

set :user_composer, true
set :update_verdors, true

# set :ssh_options, {port: 2222, keys: ['C:\vagrant\BzSWvb\puphpet\files\dot\ssh\id_rsa']}

ssh_options[:keys] = %w(C:/vagrant/BzSWvb/.vagrant/machines/default/virtualbox/private_key)

set  :keep_releases,  3

task :upload_parameters do
  origin_file = "app/config/parameters.yml"
  destination_file = shared_path + "/app/config/parameters.yml" # Notice the
  shared_path

  try_sudo "mkdir -p #{File.dirname(destination_file)}"
  top.upload(origin_file, destination_file)
end

after "deploy:setup", "upload_parameters"

set :shared_files, ["app/config/parameters.yml"]
# set :shared_children [ app_path + "/logs", web_path + "/uploads"]


# Be more verbose by uncommenting the following line
# logger.level = Logger::MAX_LEVEL