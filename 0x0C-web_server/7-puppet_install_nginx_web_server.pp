# Script that installs and configures nginx on a server

# Install nginx
package { 'nginx-installation':
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
  line   => 'rewrite ^/redirect_me https://example.com/ permanent;'
}

# Run service nginx
service { 'nginx':
  ensure  => 'running',
  name    => 'nginx',
  require => Package['nginx-installation']
}
