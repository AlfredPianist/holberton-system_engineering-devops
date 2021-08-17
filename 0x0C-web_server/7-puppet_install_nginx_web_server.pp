# Script that installs and configures nginx on a server

# Apt-get update
exec { 'apt-update':
  command => 'apt-get update',
  path    => ['/usr/bin', '/bin', '/usr/sbin']
}

# Apt-get upgrade
exec { 'apt-upgrade':
  command => 'apt-get upgrade -y',
  path    => ['/usr/bin', '/bin', '/usr/sbin'],
  require => Exec['apt-update']
}

# Install nginx
package { 'nginx':
  ensure  => 'installed',
  name    => 'nginx',
  require => Exec['apt-upgrade']
}

# Create index file with content "Holberton School for the win!"
file { 'index.html':
  path    => '/var/www/html/index.html',
  content => 'Holberton School for the win!'
}

# Add permament redirection
file_line { 'sites-available/default':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'server_name_;',
  line   => '\\trewrite ^/redirect_me https://example.com/ permanent;'
}

# Run service nginx
service { 'nginx':
  ensure  => 'running',
  name    => 'nginx',
  require => Package['nginx']
}
