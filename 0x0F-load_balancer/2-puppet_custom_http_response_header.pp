# Script that installs and configures nginx on a server

# Install nginx
package { 'nginx':
  ensure  => 'installed',
}

# Create index file with content "Holberton School for the win!"
file { '/var/www/html/index.html':
  content => 'Holberton School for the win!',
  require => Package['nginx']
}

# Add custom header 
file_line { 'custom-header':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'server_name _;',
  line    => '\\tadd-header X-Served-By "$HOSTNAME";',
  require => Package['nginx']
}

# Add permament redirection
file_line { 'redirection-301':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => '\\tadd-header X-Served-By "$HOSTNAME";',
  line    => '\\trewrite ^/redirect_me https://example.com/ permanent;',
  require => Package['nginx']
}

# Run service nginx
service { 'nginx':
  ensure  => 'running',
  require => Package['nginx']
}
