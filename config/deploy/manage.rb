server 'hina.kurorekishi.me', user: 'ec2-user', roles: [:web, :app, :db]

namespace :hina do
  task :start do
    on roles(:web) do
      execute "cd #{current_path}; (nohup bundle exec foreman start &) >& /dev/null"
    end
  end

  task :stop do
    on roles(:web) do
      execute "ps -e -o pid,command | grep [l]ita | awk '{print $1}' | xargs kill -SIGTERM"
    end
  end

  task :restart do
    on roles(:web) do
      invoke 'hina:stop'
      invoke 'hina:start'
    end
  end
end
after 'deploy:finished', 'hina:restart'
