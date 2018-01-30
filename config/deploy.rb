require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :rails_env, 'production'
set :application_name, 'riq'
set :domain, '178.62.215.181'
set :deploy_to, '/home/deploy/apps/riq'
set :repository, 'git@github.com:wv0id/riq.git'
set :branch, 'master'
set :user, 'deploy'
set :port, '22'
set :forward_agent, true # SSH forward_agent.

set :shared_dirs, fetch(:shared_dirs, []).push('public/uploads', 'log', 'tmp')
set :shared_files, fetch(:shared_files, []).push(
  '.env',
  'config/secrets.yml',
  'config/database.yml',
  'lib/icecast2/icecast.xml',
  'lib/liquidsoap/config.liq',
  'tmp/sockets',
  'tmp/pids'
)

task :environment do
   invoke :'rbenv:load'
end

task :setup do
  command %[mkdir -p "#{fetch(:shared_path)}/log/liquidsoap"]
  command %[mkdir -p "#{fetch(:shared_path)}/log/icecast2"]
  command %[touch "#{fetch(:shared_path)}/log/liquidsoap/radio.log"]
  command %[touch "#{fetch(:shared_path)}/log/icecast2/access.log"]
  command %[touch "#{fetch(:shared_path)}/log/icecast2/error.log"]
  command %[touch "#{fetch(:shared_path)}/.env"]
  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
  command %[touch "#{fetch(:shared_path)}/lib/icecast2/icecast.xml"]
  command %[touch "#{fetch(:shared_path)}/lib/liquidsoap/config.liq"]
end

desc "Deploys the current version to the server."
task :deploy do
   invoke :'git:ensure_pushed'

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}

        invoke :restart_services
      end
    end
  end
end

desc 'Restart puma service'
task :restart_services do
  command %[sudo systemctl restart puma.service]
  command %[sudo systemctl restart icecast2.service]
  command %[sudo systemctl restart liquidsoap.service]
end

