# Problematic since it fails on the problem it's trying to solve.
#package :keyring do
#  description 'See http://changelog.complete.org/archives/496-how-to-solve-the-following-packages-cannot-be-authenticated'
#  apt 'apt-get install debian-archive-keyring' do
#    post :install, ['apt-get update']
#  end
#end

package :misc do
  description 'Misc. items to make life easier'
  apt 'libtidy-dev screen man smbfs samba cron rsync vim logrotate libxml2 libxml2-dev libxslt1.1 libxslt1-dev curl libcurl4-openssl-dev'
  requires :build_essential # build_essential because it does an apt-get upgrade
end

# Install Sun's Java because NetBeans has some problems with open jdk.
# See: http://panthersoftware.com/articles/view/6/ruby-on-rails-development-on-ubuntu-9-04-jaunty-using-ruby-1-8-6
# Right now this is all combined; later will look up the right installer
# to use for doing a custom install (not immediately clear; source installer
# is close, but automatically unpacks, which we don't need and which causes an
# error)
package :java_and_netbeans do
  description "Java w/ some funky stuff to accept license"
  nb_inst = [
    'sh -c mkdir -p ~/downloads',
    'cd ~/downloads',
    'wget http://ftp.ussg.iu.edu/netbeans/6.5.1/bundles/netbeans-6.5.1-ml-ruby-linux.sh ~/downloads/',
    'sh netbeans-6.5.1-ml-ruby-linux.sh --silent'
  ].join(';')
  apt 'sun-java6-jre tzdata-java' do
    pre :install, [
      "/bin/echo -e 'sun-java6-bin shared/accepted-sun-dlj-v1-1 boolean true\\nsun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true' >/tmp/java-license.txt",
      "debconf-set-selections /tmp/java-license.txt"
    ]
    post :install, [nb_inst]
  end
end

package(:heroku) do
  description "Installs Heroku"
  gem('heroku')
  verify do
    has_gem('heroku')
  end
  requires(:rubygems)
end

package(:rails) do
  description "Installs Rails"
  gem('rails')
  verify do
    has_gem('rails')
  end
  requires(:rubygems)
end