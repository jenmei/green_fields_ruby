package :apache, :provides => :webserver do
  description 'Apache2 web server.'
  apt 'apache2 apache2.2-common apache2-mpm-worker apache2-utils libexpat1 ssl-cert' do
    post :install, 'a2enmod rewrite'
  end
  
  verify do
    has_process 'apache2'
  end
  
  requires :base_server
end

package :apache2_prefork_dev do
  description 'A dependency required by some packages.'
  apt 'apache2-prefork-dev'
end

package :passenger, :provides => :appserver do
  description 'Phusion Passenger (mod_rails)'
  gem 'passenger' do
    version('2.2.2')
    post :install, 'echo -en "\n\n\n\n" | sudo passenger-install-apache2-module'
    
    # Create the passenger conf file
    post :install, 'mkdir -p /etc/apache2/extras'
    post :install, 'touch /etc/apache2/extras/passenger.conf'
    post :install, 'echo "Include /etc/apache2/extras/passenger.conf"|sudo tee -a /etc/apache2/apache2.conf'
    
    [%q(LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-2.2.2/ext/apache2/mod_passenger.so),
    %q(PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-2.2.2),
    %q(PassengerRuby /usr/bin/ruby1.8),
    %q(PassengerMaxPoolSize 6),
    %q(PassengerPoolIdleTime 3600),
    %q(RailsEnv production)].each do |line|
      post :install, "echo '#{line}' |sudo tee -a /etc/apache2/extras/passenger.conf"
    end
    
    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'
  end
  
  verify do
    has_file '/etc/apache2/extras/passenger.conf'
    has_file '/usr/lib/ruby/gems/1.8/gems/passenger-2.2.2/ext/apache2/mod_passenger.so'
    has_directory '/usr/lib/ruby/gems/1.8/gems/passenger-2.2.2'
  end
  
  requires :apache, :apache2_prefork_dev, :rubygems
end