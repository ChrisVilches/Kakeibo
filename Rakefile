# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task(:default).clear.enhance %i[lint spec]

desc 'Lint slim pages'
task :slim_lint do
  system 'bundle exec slim-lint app/views/'
end

desc 'Analyze code using rubocop'
task :rubocop do
  system 'bundle exec rubocop'
end

task lint: %i[slim_lint rubocop]
