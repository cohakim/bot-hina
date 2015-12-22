require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

Rake::Task[:manage].invoke
invoke :manage
