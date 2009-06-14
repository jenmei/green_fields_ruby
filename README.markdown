# Ruby Outreach to Women in San Francisco June 12-13, 2009
# Automated installation of development environment on Ubuntu 9.04

This Sprinkle project will help install some packages needed for software
development, including:

This includes:

* SQLite
* Apache 2
* Passenger
* Git
* Ruby 1.8
* Ruby Gems
* Heroku
* Java and NetBeans (they're in the same package right now; should be separated later)

To use, first install a default install of Ubuntu 9.04 desktop (I've only used
32-bit, using 'ubuntu' for both username and password). You might also need to:

> sudo apt-get install debian-archive-keyring
> sudo apt-get update
> sudo apt-get install openssh-server

The first two commands deal with a possible problem that may occur where
apt-get install will display the message ["WARNING: The following packages
cannot be authenticated"][1]. This doesn't always happen (The only time I've 
experienced it was with the VMware VM I created to test this script; the
VirtualBox VM I created for testing didn't have this problem).

We need SSH server installed since Sprinkle uses SSH to connect to the machine 
to do the install.

Find out the IP address of the VM then from the sprinkle directory, type:

> sprinkle -c -v -s config/ruby_outreach.rb

This should be all that's needed to install the list above.

To do and possible to do items:

* Finish testing. Not entirely sure it all works.
* Figure out how to mark NetBeans icon on the desktop as trusted (right now, if you click on it, it asks you whether you trust it. After clicking yes, you need to double-click on the icon again to launch)
* Separate out NetBeans and Java. 
* Reorganize files -- these packages are a mix of things from various sources plus some new code.

[1]: http://changelog.complete.org/archives/496-how-to-solve-the-following-packages-cannot-be-authenticated
