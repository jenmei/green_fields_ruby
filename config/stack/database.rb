package :mysql, :provides => :database do
 description 'MySQL Database'
 apt %w( mysql-server mysql-client )
end

package :mysql_driver do
 description 'Ruby MySQL database driver'
 gem 'mysql'
end

package :sqlite3, :provides => :database do
  description 'SQLite3 database'
  apt 'sqlite3'
end

package :sqlite3_driver do
  description 'Ruby SQLite3 library.'
  apt 'libsqlite3-dev libsqlite3-ruby1.8'
  
  requires :rubygems
end