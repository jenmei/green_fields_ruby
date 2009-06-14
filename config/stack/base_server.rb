package :base_server do
  description 'Stuff to install initially'
  apt 'htop sysstat logwatch lsof'
  requires :build_essential, :wget
end

package :build_essential do
  description 'Build tools'
  apt(['build-essential']) do
    pre :install, 'apt-get update'
  end
end

package :wget do
  description 'wget'
  apt(['wget'])
  requires :build_essential
end