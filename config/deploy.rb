lock '3.4.0'

set :application, 'hina'
set :repo_url, 'git@github.com:cohakim/bot-hina.git'
set :deploy_to, '/var/bots/hina'

set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :rbenv_path, '/home/ec2-user/.rbenv'

set :pty, true
