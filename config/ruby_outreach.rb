%w(base_server database misc ruby rubygems scm server).each do |r|
  require File.join(File.dirname(__FILE__), 'stack', r)
end

# What we're installing to your server
# Take what you want, leave what you don't
# Build up your own and strip down your server until you get it right.
policy :ruby_outreach, :roles => :app do
#  requires :keyring
  requires :webserver                 # Apache
  requires :appserver                 # Passenger
  requires :ruby
  requires :rubygems
  requires :rails
  requires :mysql
  requires :mysql_driver
  requires :sqlite3
  requires :sqlite3_driver
  requires :scm                       # Git

  # The next three packages are in misc.rb
  requires :heroku
  requires :misc                      # screen, vim, etc.
  requires :java_and_netbeans
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    begin
      recipes 'Capfile'
    rescue LoadError
      recipes 'deploy'
    end
  end

  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end