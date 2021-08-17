# Script that installs and configures nginx on a server

# Install nginx
package { 'nginx-installation':
  ensure => 'installed',
  name   => 'nginx'
}

# Create index file with content "Holberton School for the win!"
file { 'index.html':
  path    => '/var/www/html/index.html',
  content => 'Holberton School for the win!'
}

# Add permament redirection
file_line { 'redirection-301':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'server_name _;',
  line   => 'rewrite ^/redirect_me https://example.com/ permanent;'
}

# Run service nginx
service { 'nginx':
  ensure  => 'running',
  require => Package['nginx-installation']
}
