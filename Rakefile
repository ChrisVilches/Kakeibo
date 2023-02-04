# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# TODO: Rake should exit with a non-zero code if any task fails.
#       For example if tests are OK, but Rubocop isn't,
#       then 'bundle exec rake' should exit with a non-zero code.

task(:default).clear.enhance %i[lint spec]

desc 'Lint slim pages'
task :slim_lint do
  system 'bundle exec slim-lint app/views/'
end

desc 'Analyze code using rubocop'
task :rubocop do
  system 'bundle exec rubocop'
end

desc 'Analyze code using rubycritic'
task :rubycritic do
  system 'bundle exec rubycritic'
end

task lint: %i[slim_lint rubocop rubycritic]
